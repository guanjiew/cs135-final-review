;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname more-alfs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Create a list of the first n even Nats, starting from 0
;; first-n-evens: Nat->(list of Nat)
(define (first-n-evens n)
  (build-list n (lambda(i) (* 2 i)))
  )

(check-expect (first-n-evens 4) (list 0 2 4 6))

;; Cumulative sum: Produce a list whose i-th element is the
;; sum of the first i elements of input list
;; cumu-suml: (listof Nat) -> (listof Nat)
(define (cumu-sum lon)
  (rest (foldr (lambda (x y) (cons (- (first y) x) y))
               (list (foldr + 0 lon))
               lon)))

(check-expect (cumu-sum empty) empty)
(check-expect (cumu-sum '(1))'(1))
(check-expect (cumu-sum '(1 2 3 4 5 6)) '(1 3 6 10 15 21))


;; Count-squares: consumes a (listof Int) and produces the number of perfect squares in the list
;; count-squares: (listof Int) -> Nat
(define (count-squares lon)
  (foldr (lambda(x y)(cond[(integer? (sqrt x))(add1 y)][else y]))
         0 lon)
  )

(check-expect (count-squares '(1 3 4 8 16 13 25 169)) 5)

;; Ascending: consumes a (listof Int) and produces if the list if ascending
;; ascending: (listof Int)-> boolean
;;(check-expect (ascending? (cons 1 (cons 2 (cons 3 (cons 4 empty))))) true)
(define (ascending? loi)
  (or (empty? loi)
      (number? (foldl (lambda (x y) (cond [(false? y) y]
                                          [(> x y) x]
                                          [else false]))
                (first loi) (rest loi)))))

(ascending? (list 1))