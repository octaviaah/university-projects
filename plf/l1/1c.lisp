(defun sublists (l)
	(cond
		((atom l) nil)
		(T (apply 'append (list l) (mapcar 'sublists l)))
	)
)