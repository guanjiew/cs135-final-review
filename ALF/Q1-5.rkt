;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Q1-4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Consumes a natural number n and produces true if the given number is prime; false otherwise
;; is-prime?: Nat -> Boolean
(define (is-prime? n)
  (foldr (lambda (num cur_bool)
                 (and (not (= 0 (remainder n num))) cur_bool))
         true (range 2 n 1)
  )
)

(check-expect (is-prime? 143) #f)
(check-expect (is-prime? 56)  #f)
(check-expect (is-prime? 17)  #t)
(check-expect (is-prime? 2)   #t)

;; Sum all positive numbers in a list
;; sum-pos: (listof integer) -> integer
(define (sum-pos lon)
  (foldr (lambda (num cur_sum)
                (cond [(> num 0) (+ cur_sum num)]
                      [else cur_sum]))
         0 lon
  )
)

(define test-list (list 1 -10 -5 7 9 11 13))
(check-expect (sum-pos test-list) 41)

;; Consumes a positive integer n and produces a list of n lists of natural numbers,
;; where the i-th list contains the first i + 1 natural numbers.  
;; increasing-list: Nat -> (listof Nat)
(define (increasing-lists n)
(build-list n (lambda (x)
                (build-list (add1 x) identity))))

(check-expect (list (list 0) (list 0 1) (list 0 1 2) (list 0 1 2 3) (list 0 1 2 3 4) (list 0 1 2 3 4 5) (list 0 1 2 3 4 5 6) (list 0 1 2 3 4 5 6 7)) (increasing-lists 8))

;; Produce a diagnal matrix of size n
;; identity: Nat -> (listof (listof Integer))
(define (identity-matrix n )
  (build-list n (lambda (row)
    (build-list n (lambda (col)
                  (cond [(= row col) 1]
                        [else 0]
                        ))))))

(check-expect (list (list 1 0 0 0 0) (list 0 1 0 0 0) (list 0 0 1 0 0) (list 0 0 0 1 0) (list 0 0 0 0 1))(identity-matrix 5))

;; map-lofn produces a list of lists, where each sublist contains the result after applying each function from the consumed list to each number in the consumed 
;; map-lofn: Nat -> (listof Any)
(define (map-lofn lons funcs)
  (map (lambda (func) 
        (map  (lambda (lon) (func lon)) 
        (filter number? lons)
        )) funcs))

(check-expect (list (list 1 4 16) (list 2 3 5) (list #false #false #false)) (map-lofn (list 1 2 (list 12 12) 4 't) (list sqr add1 zero?)))