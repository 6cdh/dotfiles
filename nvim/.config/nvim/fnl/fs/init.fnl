(local M {})

(macro dispatch [cond f1 f2]
  `(if ,cond ,f1 ,f2))

;; numeric

(fn M.inc [num]
  "number | string -> number
  O(1). Increase `num`. `num` may be a number or string that can be converted to a number."
  (+ num 1))

(fn M.dec [num]
  "number | string -> number
  O(1). Decrease `num`. `num` may be a number or string that can be converted to a number."
  (- num 1))

(fn M.odd? [num]
  "number | string -> bool
  O(1). Return true if `num` is odd, false otherwise. If `num` is a string, it must be
  convertible to a number."
  (= (% num 2) 1))

(fn M.even? [num]
  "number | string -> bool
  O(1). Return true if `num` is even, false otherwise. If `num` is a string, it must be
  convertible to a number."
  (not (M.odd? num)))

;; type

(fn M.nil? [v]
  "any -> bool
  O(1). Return true if `v` is nil, false otherwise."
  (= v nil))

(fn M.tbl? [v]
  "any -> bool
  O(1). Return true if `v` is a table, false otherwise."
  (= (type v) :table))

(fn M.list? [v]
  "any -> bool
  O(1). Return true if `v` is a list, false otherwise. A table `t` is a list if it is empty
  or `t[1] != nil`."
  (or (M.empty? v) (not (M.nil? (?. v 1)))))

(fn flt_eq? [flt1 flt2]
  (-> (- flt1 flt2) (math.abs) (< 1e-06)))

(fn subset? [tbl1 tbl2]
  "Is tbl1 a subset of tbl2?"
  (M.all (fn [v k]
           (M.eq? (. tbl2 k) v)) tbl1))

(fn tbl_eq? [tbl1 tbl2]
  (and (subset? tbl1 tbl2) (subset? tbl2 tbl1)))

(fn M.eq? [v1 v2]
  "any -> any -> bool
  O(1) if `v1` and `v2` are not both table. Basically the same as `v1 == v2` in Lua except
  * for table, it will perform `eq?` for each key
  and corresponding value.
  * for number, it will perform float equality comparisons."
  (match [(type v1) (type v2)]
    [:number :number] (flt_eq? v1 v2)
    [:table :table] (tbl_eq? v1 v2)
    _ (= v1 v2)))

(fn M.copy [tbl]
  (M.map M.id tbl))

;; Lisp primitives

(fn M.cons [elem lst]
  "any -> list -> list
  O(n). Insert `elem` in front of `lst`. A new list would be created and returned."
  (let [nlst (M.copy lst)]
    (table.insert nlst 1 elem)
    nlst))

(fn M.car [lst]
  "list -> any"
  "O(1). Return the first element of `lst`."
  (. lst 1))

(fn M.cdr [lst]
  "list -> list
  O(n). Remove the first element of `lst` and return `lst`. A new table would be created
  and returned."
  (let [nlst (M.copy lst)]
    (table.remove nlst 1)
    nlst))

;; List

(fn M.empty? [v]
  "table | string -> bool
  O(1). Return true if `v` is an empty string or empty table, false otherwise."
  (match [(type v)]
    [:string] (= v "")
    [:table] (M.nil? (next v))
    _ false))

(fn M.member? [elem tbl]
  "any -> table -> bool
  O(n). Return true if `elem` is one of the values of `tbl`."
  (M.any #(M.eq? elem $1) tbl))

(fn M.tbl-keys [tbl]
  "table -> list
  O(n). Return the list of keys of `tbl`."
  (let [ntbl []]
    (M.for_each #(M.append ntbl $2) tbl)
    ntbl))

(fn M.tbl-values [tbl]
  "table -> list
  O(n). Return the list of values of `tbl`."
  (let [ntbl []]
    (M.for_each #(M.append ntbl $1) tbl)
    ntbl))

;; functional

(fn M.id [v]
  "any -> any
  O(1). Identity function."
  v)

;; all

(fn all_lst [pred lst]
  (for [i 1 (length lst)]
    (if (not (pred (. lst i) i)) (lua "return false")))
  true)

(fn all_tbl [pred tbl]
  (each [k v (pairs tbl)]
    (if (not (pred v k)) (lua "return false")))
  true)

(fn M.all [pred tbl]
  "(v -> k -> bool) | (v -> bool) -> {k v}
  O(n * pred). Return true if predicate `pred` return true for all elements of `tbl`,
  false otherwise."
  ((dispatch (M.list? tbl) all_lst all_tbl) pred tbl))

;; any

(fn M.any [pred tbl]
  "(v -> k -> bool) | (v -> bool) -> {k v}
  O(n * pred). Return true if predicate `pred` return true for at least elements of `tbl`,
  false otherwise."
  (not (M.all #(not (pred $...)) tbl)))

;; append

(fn M.append [tbl v]
  "table -> any -> table
  O(1). Append `v` into `tbl`."
  (tset tbl (+ (length tbl) 1) v)
  tbl)

;; map

(fn for_each_in_lst [f lst]
  (for [i 1 (length lst)]
    (f (. lst i) i)))

(fn for_each_in_tbl [f tbl]
  (each [i v (pairs tbl)]
    (f v i)))

(fn M.for_each [f tbl]
  "(v -> k -> any) | (v -> any) -> table | list -> table | list
  O(n * f). Apply function `f` for all elements of `tbl` without change `tbl` or create a new
  list."
  ((dispatch (M.list? tbl) for_each_in_lst for_each_in_tbl) f tbl))

(fn M.map [f tbl]
  "(v -> k -> any) | (v -> any) -> table -> table
  O(n * f). Like `for_each` but a new table would be created."
  (let [ntbl {}]
    (if (M.list? tbl) (M.for_each #(M.append ntbl (f $1 $2)) tbl)
        (M.for_each #(tset ntbl $2 (f $1 $2)) tbl))
    ntbl))

;; filter

(fn M.filter [pred tbl]
  "(v -> k -> bool) | (v -> bool) -> table -> table
  O(n * pred). Return a new list with the elements of `tbl` for which `pred` returns true."
  (M.map #(when (pred $1 $2)
            $1) tbl))

;; fold

(fn M.foldl [f init lst]
  "(init -> v -> k -> init) | (init -> v -> init) -> init -> table -> init
  O(n * f). Start with `init`, reduce `lst` with function `f`, from left to right."
  (var acc init)
  (M.for_each #(set acc (f acc $1 $2)) lst)
  acc)

(fn M.foldr [f init lst]
  "(v -> init -> k -> init) | (v -> init -> init) -> init -> table -> init
  O(n * f). Start with `init`, reduce `lst` with function `f`, from right to left."
  (var acc init)
  (M.for_each #(set acc (f $1 acc $2)) (M.reverse lst))
  acc)

;; reverse

(fn M.reverse [lst]
  "list -> list
  O(n). Reverse `lst`."
  (M.map #(. lst (- (+ (length lst) 1) $2)) lst))

;; intersect 

(fn M.intersect [tbl1 tbl2]
  "table -> table -> list
  O(n). Return the intersection of `tbl1` and `tbl2`."
  (M.tbl-values (M.map #(if (not (M.nil? (. tbl2 $2))) $2) tbl1)))

;; zip

(fn M.zip_with [f lst1 lst2]
  "(v1 -> v2 -> any) -> {k1 v1} -> {k2 v2} -> list
  O(min(m, n)). Return a list corresponding pair of `tbl1` and `tbl2`."
  (let [nlst []]
    (for_each_in_lst #(M.append nlst (f (. lst1 $1) (. lst2 $1)))
                     (M.intersect lst1 lst2))
    nlst))

(fn M.zip [tbl1 tbl2]
  "table -> table -> list
  O(min(m, n)). Return a list of corresponding pair of `tbl1` and `tbl2`."
  (M.zip_with #[$1 $2] tbl1 tbl2))

;; neg functions register

(fn neg-register [fname]
  (tset M (.. "!" fname) #(not ((. M fname) $...))))

(fn neg-registers [fnames]
  (M.for_each #(neg-register $1) fnames))

(neg-registers [:tbl? :list? :nil? :flt_eq? :tbl_eq? :eq? :empty? :member?])

M

