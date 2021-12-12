;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Q3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; 4a) formula x.size = x.left.size + x.right.size + 1
;; 4b)

;; An Integer Size Binary Search Tree (SizeIntBT) is one of:
;; * empty
;; * an SizeIntBT

(define-struct sint-node (key size left right))
;; An SizeIntBT is a (make-sint-node Int Int IntBT IntBT)

(define test-size-bst
  (make-sint-node 10 7
                  (make-sint-node 8 3
                                (make-sint-node 4 1 empty empty)
                                (make-sint-node 5 1 empty empty))
                  (make-sint-node 12 3
                                (make-sint-node 14 1 empty empty)
                                (make-sint-node 15 1 empty empty))))

;; Assume 0 < i <= #of SizeIntBT
(define (os-select bst i)
  (cond [(empty? bst) #false]
        [(= (sint-node-size bst) i) (sint-node-key bst)]
        [(< (sint-node-size bst) i) (os-select (sint-node-right bst) i - (sint-node-szie bst))]
        [else (os-select (sint-node-left bst) i)]))

(os-select test-size-bst 3)

