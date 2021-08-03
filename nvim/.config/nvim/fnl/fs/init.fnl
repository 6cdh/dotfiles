(local _M {})

;; number

(fn _M.inc [num]
  "(num n) => n -> n"
  (+ num 1))

(fn _M.dec [num]
  "(num n) => n -> n"
  (- num 1))

;; bool

(fn _M.tbl? [tbl]
  (= (type tbl) :table))

(fn _M.list? [tbl]
  "{k v} -> bool"
  "[v] -> bool"
  (or (_M.empty? tbl) (_M.!nil? (?. tbl 1))))

(fn _M.odd? [num]
  "(num n) => n -> bool"
  (= (% num 2) 1))

(fn _M.even? [num]
  "(num n) => n -> bool"
  (not (_M.odd? num)))

(fn _M.nil? [v]
  "a -> bool"
  (= v nil))

(fn flt_eq? [flt1 flt2]
  "(num n) => n -> n -> bool"
  (< (math.abs (- flt1 flt2)) 1e-06))

(fn tbl_eq? [tbl1 tbl2]
  "{k1 v1} -> {k2 v2} -> bool"
  (and (_M.all #(_M.eq? (. tbl2 $2) $1) tbl1)
       (_M.all #(_M.eq? (. tbl1 $2) $1) tbl2)))

(fn _M.eq? [v1 v2]
  "a -> b -> bool"
  (if (= v1 v2) true (match [(type v1) (type v2)]
                       [:number :number] (flt_eq? v1 v2)
                       [:table :table] (tbl_eq? v1 v2)
                       _ false)))

;; List

(fn _M.empty? [tbl]
  "[a] -> bool"
  "{k v} -> bool"
  ":a -> bool"
  (match [(type tbl)]
    [:string] (= tbl "")
    [:table] (_M.nil? (next tbl))
    _ false))

(fn _M.cons [elem tbl]
  "a -> [a] -> [a]"
  (table.insert tbl 1 elem)
  tbl)

(fn _M.first [tbl]
  "[a] -> a"
  (. tbl 1))

(fn _M.rest [tbl]
  "[a] -> [a]"
  (table.remove tbl 1)
  tbl)

(fn _M.member? [elem tbl]
  "a -> [a] -> bool"
  "v -> {k v} -> bool"
  (_M.any #(_M.eq? elem $1) tbl))

(fn _M.tbl-keys [tbl]
  "{k v} -> [k]"
  "[v] -> [i]"
  (let [ntbl []]
    (_M.map2 #(_M.append ntbl $2) tbl)
    ntbl))

(fn _M.tbl-values [tbl]
  "{k v} -> [v]"
  "[v] -> [v]"
  (let [ntbl []]
    (_M.map2 #(_M.append ntbl $1) tbl)
    ntbl))

;; all

(fn _M.iall [pred tbl]
  "(a -> i -> bool) -> [a] -> bool"
  (for [i 1 (length tbl)]
    (if (not (pred (. tbl i) i)) (lua "return false")))
  true)

(fn _M.all [pred tbl]
  "(a -> i -> bool) -> [a] -> bool"
  "(v -> k -> bool) -> {k v} -> bool"
  (if (_M.list? tbl) (_M.iall pred tbl)
      (do
        (each [k v (pairs tbl)]
          (if (not (pred v k)) (lua "return false")))
        true)))

;; any

(fn _M.any [pred tbl]
  "(a -> i -> bool) -> [a] -> bool"
  "(v -> k -> bool) -> {k v} -> bool"
  (not (_M.all #(not (pred $...)) tbl)))

;; append

(fn _M.append [tbl v]
  "[a] -> a -> [a]"
  (tset tbl (+ (length tbl) 1) v)
  tbl)

;; map

(fn _M.imap2 [f tbl]
  "(a -> i -> b) -> [a] -> [b]"
  (let [len (length tbl)]
    (for [i 1 len]
      (f (. tbl i) i))))

(fn _M.map2 [f tbl]
  "(a -> i -> b) -> [a] -> [b]"
  "(v -> k -> a) -> {k v} -> {a}"
  (each [i v (pairs tbl)]
    (f v i)))

(fn _M.map [f tbl]
  "(a -> i -> b) -> [a] -> [b]"
  "(v -> k -> a) -> {k v} -> {a}"
  (let [ntbl {}]
    (if (_M.list? tbl) (_M.imap2 #(_M.append ntbl (f $1 $2)) tbl)
        (_M.map2 #(tset ntbl $2 (f $1 $2)) tbl))
    ntbl))

;; filter

(fn _M.filter [pred tbl]
  "(a -> i -> bool) -> [a] -> [a]"
  "(v -> k -> bool) -> {k v} -> {k v}"
  (_M.map #(if (pred $1 $2) $1) tbl))

(fn _M.foldl [f init tbl]
  "(acc -> v -> r) -> acc -> [v] -> r"
  (var acc init)
  (_M.map #(set acc (f acc $1)) tbl)
  acc)

(fn _M.foldr [f init tbl]
  "(v -> acc -> r) -> acc -> [v] -> r"
  (var acc init)
  (_M.map #(set acc (f $1 acc)) (_M.reverse tbl))
  acc)

;; reverse

(fn _M.reverse [tbl]
  "[v] -> [v]"
  (_M.map #(. tbl (- (+ (length tbl) 1) $2)) tbl))

;; intersect 

(fn _M.intersect [tbl1 tbl2]
  "[a] -> [b] -> [i]"
  "{k v} -> {k v2} -> [k]"
  (_M.tbl-values (_M.map #(if (_M.!nil? (. tbl2 $2)) $2) tbl1)))

;; zip

(fn _M.zipWith [f tbl1 tbl2]
  "(a -> b -> c) -> [a] -> [b] -> [c]"
  "(a -> b -> c) -> {k a} -> {k b} -> {k c}"
  (if (_M.list? tbl1)
      (let [ntbl []]
        (_M.imap2 #(_M.append ntbl (f (. tbl1 $1) (. tbl2 $1)))
                  (_M.intersect tbl1 tbl2))
        ntbl)
      (let [ntbl {}]
        (_M.map2 #(tset ntbl $1 (f (. tbl1 $1) (. tbl2 $1)))
                 (_M.intersect tbl1 tbl2))
        ntbl)))

(fn _M.zip [tbl1 tbl2]
  "[a] -> [b] -> [[a b]]"
  "{k a} -> {k b} -> {k [a b]}"
  (_M.zipWith #[$1 $2] tbl1 tbl2))

;; neg functions register

(fn neg-register [ns fname]
  (tset ns (.. "!" fname) #(not ((. ns fname) $1 $2 $3))))

(macro neg-registers [ns fnames]
  `(_M.imap2 #(neg-register ,ns $1) ,fnames))

(neg-registers _M [:tbl?
                   :list?
                   :odd?
                   :even?
                   :nil?
                   :flt_eq?
                   :tbl_eq?
                   :eq?
                   :empty?
                   :member?])

_M

