(defun nthElem (list n index)
	(cond
		((null list) nil)
		((= n index) (car list))
		(T (nthElem (cdr list) n (+ index 1)))
	)
)

(defun nthElemMain (list n)
	(nthElem list n 1)
)