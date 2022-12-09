(local M {})

(fn M.table-values [tbl]
  (icollect [_ v (pairs tbl)]
    v))

(fn M.imap [f arr]
  (icollect [k v (ipairs arr)]
    (f k v)))

(fn M.map [f tbl]
  (collect [k v (pairs tbl)]
    (values k (f k v))))

M
