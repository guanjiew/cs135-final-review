;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname BST) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Binary Search Tree
;; requires:
;; top node key is greater than all left branch keys
;; top node key is less than all right branch keys
;; A BST is one of
;; * empty
;; * (make-node Int Any BST BST)
(define-struct node [key value left right])
;; Sometimes we omit the value field
;; A BST is one of
;; * empty
;; * (make-node Int BST BST)
;; (define-struct node [key left right])
(define test-bst
  (make-node 3 'c
             (make-node 1 'f
                        empty
                        (make-node 2 't empty empty))
             (make-node 6 'y
                        (make-node 4 'g empty empty)
                        (make-node 10 'w
                                   (make-node 8 'h empty empty) empty)
                        )
             )
  )

;; 1a) A C D
;; 1b)
;; bst-to-list: BST → (listof (list Int Any))
;; the result will be sorted!
(define (bst-to-list bst)
  (cond [(empty? bst) empty]
        [else (append
               (bst-to-list (node-left bst))
               (list (list (node-key bst) (node-value bst)))
               (bst-to-list (node-right bst)))]))

(check-expect (list (list 1 'f) (list 2 't) (list 3 'c) (list 4 'g) (list 6 'y) (list 8 'h) (list 10 'w)) (bst-to-list test-bst))
;;1c) insert: Int Any BST → BST
;; if the key (Int) exists then update the value (Any) at the key
(define (insert key val bst)
  (cond [(empty? bst) (make-node key val empty empty)]
        [(< key (node-key bst)) (make-node
                                 (node-key bst)
                                 (node-value bst)
                                 (insert key val (node-left bst))
                                 (node-right bst))]
        [(> key (node-key bst)) (make-node
                                 (node-key bst)
                                 (node-value bst)
                                 (node-left bst)
                                 (insert key val (node-right bst)))]
        [else (make-node key val (node-left bst) (node-right bst))]))

(define after-insert-14-test-bst
  (make-node 3 'c
             (make-node 1 'f '()
                        (make-node 2 't '() '()))
             (make-node 6 'y
                        (make-node 4 'g '() '())
                        (make-node 10 'w
                                   (make-node 8 'h '() '())
                                   (make-node 14 'm '() '())))))

(check-expect after-insert-14-test-bst (insert 14 'm test-bst))

(define after-insert-2-test-bst
  (make-node 3 'c
             (make-node 1 'f '()
                        (make-node 2 'n '() '()))
             (make-node 6 'y
                        (make-node 4 'g '() '())
                        (make-node 10 'w
                                   (make-node 8 'h '() '())
                                   '()))))

(check-expect after-insert-2-test-bst (insert 2 'n test-bst))

;; 1d)
;; bst-min-key: BST → (anyof false (list Int Any))
(define (bst-min-key bst)
  (cond [(empty? bst) false]
        [(empty? (node-left bst)) (list (node-key bst) (node-value bst))]
        [else (bst-min-key (node-left bst))]))

(check-expect (list 1 'f) (bst-min-key test-bst))

;; bst-remove-key: Int BST → BST
;; Do nothing if the key doesn’t exist
(define (bst-remove-key key bst)
  (cond [(empty? bst) empty]
        [(> key (node-key bst)) (make-node
                                 (node-key bst)
                                 (node-value bst)
                                 (node-left bst)
                                 (bst-remove-key key (node-right bst)))]
        [(< key (node-key bst)) (make-node
                                 (node-key bst)
                                 (node-value bst)
                                 (bst-remove-key key (node-left bst))
                                 (node-right bst))]
        [(empty? (node-right bst)) (node-left bst)]
        [else (local [(define min-right (bst-min-key (node-right bst)))]
                (make-node (first min-right)
                           (second min-right)
                           (node-left bst)
                           (bst-remove-key (first min-right)
                                       (node-right bst))))]))
(define after-remove-4-test-bst
  (make-node 3 'c
             (make-node 1 'f '()
                        (make-node 2 't '() '()))
             (make-node 6 'y '()
                        (make-node 10 'w
                                   (make-node 8 'h '() '())
                                   '()))))
  
(check-expect after-remove-4-test-bst (bst-remove-key 4 test-bst))

;;1f)
;; bst-path: Int BST → (anyof false (listof (list Int Any)))
(define (bst-path key bst)
  (cond [(empty? bst) false]
        [(= key (node-key bst)) (list (list key (node-value bst)))]
        [else (local [(define rec
                        (bst-path key
                                  (cond [(> key (node-key bst)) (node-right bst)]
                                        [else (node-left bst)])))]
                (cond [(false? rec) false]
                      [else (cons (list (node-key bst) (node-value bst)) rec)]))]))

(bst-path 10 test-bst )