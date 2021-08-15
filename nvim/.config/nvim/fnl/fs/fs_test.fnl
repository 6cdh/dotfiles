(local fs (require :fs))
(local view vim.inspect)

(fn asserteq [exp res]
  (assert (fs.eq? res exp) (.. "Expect " (view exp) " Got " (view res))))

(assert (fs.eq? true true))
(assert (fs.eq? false false))
(assert (not (fs.eq? true false)))
(assert (not (fs.eq? false true)))

(assert (fs.!eq? true false))
(assert (fs.!eq? false true))
(assert (not (fs.!eq? true true)))
(assert (not (fs.!eq? false false)))

(asserteq true (fs.eq? 1.2 (* 0.2 6)))
(asserteq true (fs.eq? [] []))
(asserteq true (fs.eq? [1] [1]))
(asserteq true (fs.eq? "1 " "1 "))
(asserteq true (fs.eq? nil nil))
(asserteq false (fs.eq? [1] []))
(asserteq false (fs.eq? [1] :1))
(asserteq false (fs.eq? nil false))

(asserteq true (fs.list? []))
(asserteq true (fs.list? [1]))
(asserteq true (fs.list? [1 2]))
(asserteq true (fs.list? {1 :a}))
(asserteq false (fs.list? {:a :a}))
(asserteq false (fs.list? {2 2 3 3}))

(asserteq true (fs.odd? 1))
(asserteq false (fs.odd? 0))
(asserteq true (fs.even? 0))
(asserteq false (fs.even? 1))

(asserteq true (fs.nil? nil))
(asserteq false (fs.nil? false))
(asserteq false (fs.nil? ""))
(asserteq false (fs.nil? []))
(asserteq false (fs.nil? {}))

(asserteq true (fs.empty? []))
(asserteq true (fs.empty? {}))
(asserteq true (fs.empty? ""))
(asserteq false (fs.empty? [1]))
(asserteq false (fs.empty? {:a :a}))
(asserteq false (fs.empty? :1))

(asserteq [1 1] (fs.cons 1 [1]))
(asserteq [1 2 3 4 [123]] (fs.cons 1 [2 3 4 [123]]))
(asserteq [[321] [123]] (fs.cons [321] [[123]]))

(asserteq 1 (fs.car [1 2]))
(asserteq 2 (fs.car [2 3]))
(asserteq [1 2 3] (fs.car [[1 2 3] 2 3]))

(asserteq [2 3] (fs.cdr [1 2 3]))
(asserteq [[2 3]] (fs.cdr [1 [2 3]]))

(asserteq true (fs.member? 1 [1 2 3]))
(asserteq true (fs.member? [1] [[1] 2 3]))
(asserteq true (fs.member? [4] {:1 :1 :2 :2 :3 [4]}))
(asserteq false (fs.member? 4 [1 2 3]))
(asserteq false (fs.member? [4] [1 2 3]))
(asserteq false (fs.member? :3 {:1 :1 :2 :2 :3 [4]}))

(asserteq [2 3 4] (fs.tbl-keys {2 3 3 4 4 5}))
(asserteq [3 4 5] (fs.tbl-values {2 3 3 4 4 5}))

(asserteq true (fs.all #(= true $1) [true true true]))
(asserteq true (fs.all #(> $1 0) [1 2 3 4]))
(asserteq false (fs.all #(= true $1) [true false true]))
(asserteq false (fs.all #(> $1 0) [1 2 3 4 -5]))

(asserteq true (fs.any #(= true $1) [true false true]))
(asserteq true (fs.any #(> $1 0) [1 2 3 4 -5]))
(asserteq false (fs.any #(not= true $1) [true true true]))
(asserteq false (fs.any #(< $1 0) [1 2 3 4]))

(asserteq [1 2] (fs.append [1] 2))
(asserteq [1 [2 3]] (fs.append [1] [2 3]))

(asserteq [2 4 6 -8 -10] (fs.map #(* $1 2) [1 2 3 -4 -5]))
(asserteq [2 3 4 5 6 7] (fs.map #(fs.inc $1) [1 2 3 4 5 6]))
(asserteq [-1 0 1 2 3 4 5] (fs.map #(fs.dec $1) [0 1 2 3 4 5 6]))
(asserteq [1 4 3] (fs.map #(if (fs.even? $2) (* $1 2) $1) [1 2 3]))
(asserteq {:a 2 :b 4 :c 6} (fs.map #(* 2 $1) {:a 1 :b 2 :c 3}))
(asserteq {2 3 3 4} (fs.map #(fs.inc $1) {2 2 3 3}))

(asserteq [1 2] (fs.filter #(> $1 0) [1 2 -1 0 -2]))
(asserteq [1 2 0] (fs.filter #(>= $1 0) [1 2 -1 0 -2]))
(asserteq {:c 3} (fs.filter #(> $1 2) {:a 1 :b 2 :c 3}))
(asserteq {:a 1} (fs.filter #(= $2 :a) {:a 1 :b 2 :c 3}))
(asserteq {3 4} (fs.filter #(> $2 2) {2 3 3 4}))

(asserteq 8 (fs.foldl #(+ $1 $2) 0 [2 3 3]))
(asserteq [3 4 4] (fs.foldl #(fs.append $1 (fs.inc $2)) [] [2 3 3]))
(asserteq 8 (fs.foldr #(+ $1 $2) 0 [2 3 3]))
(asserteq [4 4 3] (fs.foldr #(fs.append $2 (fs.inc $1)) [] [2 3 3]))

(asserteq [1 2 3 4] (fs.intersect [3 4 5 6] [9 8 7 6 5 4]))
(asserteq [5 6] (fs.intersect {3 4 5 6 6 7} {9 8 6 6 5 4}))

(asserteq [[1 2] [2 3]] (fs.zip [1 2] [2 3]))
(asserteq [[1 2] [2 3] [3 4]] (fs.zip [1 2 3] [2 3 4]))

(asserteq [5 7 9] (fs.zip_with #(+ $1 $2) [1 2 3] [4 5 6 7]))
(asserteq [4 10 18] (fs.zip_with #(* $1 $2) [1 2 3] [4 5 6 7]))

