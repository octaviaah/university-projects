(defun level (x n lvl nrch l)
	(cond
		((eq x n) lvl)
		((null l) nil)
		((= nrch 0) l)
		(t 
			(defvar aux nil)
			(setq aux (level x (car l) (+ lvl 1) (cadr l) (cddr l)))
			(cond 
				((listp aux) (level x n lvl (- nrch 1) aux))
				(t aux)
			)
		)
	)
)

(defun levelMain (x l)
	(level x (car l) 0 (cadr l) (cddr l))  
)