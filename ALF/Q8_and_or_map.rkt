;; my-ormap: (X->boolean) (listof X) -> boolean
;; a. Recursively using basic Racket functions
(define my-ormap1?
  (lambda (pred lst)
    (cond
        ((empty? lst) #f)
        ((pred (first lst)) #t)
        (else
            (or (pred (first lst))
                (my-ormap1? pred (rest lst))))
      )
    )
)
;; my-andmap: (X->boolean) (listof X) -> boolean
;; a. Recursively using basic Racket functions
(define my-andmap1?
    (lambda (pred lst)
        (cond
            ((empty? lst) #t)
            (else
                (and (pred (first lst))
                     (my-andmap1? pred (rest lst))))
        )
    )
)


;; b. Using Foldr
(define (my-ormap? pred lst)
  (foldr (lambda (a b) (or (pred a) b)) #f lst))

  
;; b. Using Foldr function
(define my-andmap?
    (lambda (pred lst)
        (foldr (lambda (a b) (and (pred a) b)) #t lst)
    )
)



;; c. Using andmap
(define my-ormap3?
    (lambda (pred lst)
        (not (my-andmap? (lambda (x) (not (pred x))) lst))
    )
)

;; c. Using my-ormap?
(define my-andmap3?
    (lambda (pred lst)
        (not (my-ormap? (lambda (x) (not (pred x))) lst))
    )
)

(check-expect #t (my-andmap1? positive? '(1 2 3)))
(check-expect #f (my-andmap? positive? '(1 -2 3)))
(check-expect #t (my-andmap3? positive? '(1 2 3)))


(check-expect #t (my-ormap1? positive? '(1 2 3)))
(check-expect #t (my-ormap? positive? '(1 -2 3)))
(check-expect #f (my-ormap3? positive? '(-1 -2 -3)))