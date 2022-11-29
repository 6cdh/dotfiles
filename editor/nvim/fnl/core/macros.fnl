(fn types [ts]
  (fn rec [ts]
    (if (list? ts) (icollect [_ val (ipairs ts)]
                    (rec val))
        (table? ts) (collect [key val (pairs ts)]
                      (values key (rec val)))
        (sym? ts) (view ts)
        ts))

  (rec ts))

{: types}

