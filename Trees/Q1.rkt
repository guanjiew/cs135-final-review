;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Q1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; An Integer Binary Tree (IntBT) is one of:
;; * empty
;; * an IntNode

(define-struct int-node (key left right))
;; An IntNode is a (make-int-node Int IntBT IntBT)

(define test-bst
  (make-int-node 3
             (make-int-node 1
                        empty
                        (make-int-node 2 empty empty))
             (make-int-node 6
                        (make-int-node 4 empty empty)
                        (make-int-node 10
                                   (make-int-node 8 empty empty) empty)
                        )
             )
  )


(define test-tree
  (make-int-node 8
             (make-int-node 9
                        empty
                        (make-int-node 7 empty empty))
             (make-int-node 4
                        (make-int-node 4 empty empty)
                        (make-int-node 11
                                   (make-int-node 2 empty empty) empty)
                        )
             )
  )


(define (min-key bt)
  (cond [(and (empty? (int-node-left bt))
              (empty? (int-node-right bt))) (int-node-key bt)]
        [(empty? (int-node-left bt))
         (min (int-node-key bt)
              (min-key (int-node-right bt)))]
        [(empty? (int-node-right bt))
         (min (int-node-key bt)
              (min-key (int-node-left bt)))]
        [else (min (int-node-key bt)
                   (min-key (int-node-left bt))
                   (min-key (int-node-right bt)))]))

(min-key test-tree)


(define (min-key/bst bst)
  (cond [(empty? (int-node-left bst))
         (int-node-key bst)]
        [else (min-key/bst (int-node-left bst))]))

(min-key/bst test-bst)

;; keys-in-range: Num Num BST → (listof Num)
;; requires: lo <= hi
(define (keys-in-range lo hi bst)
  (cond [(empty? bst) empty]
        [(< (int-node-key bst) lo)
         (keys-in-range lo hi (int-node-right bst))]
        [(and (>= (int-node-key bst) lo) (<= (int-node-key bst) hi))
         (append (keys-in-range lo hi (int-node-left bst))
                 (cons (int-node-key bst)
                       (keys-in-range lo hi (int-node-right bst))))]
        [(> (int-node-key bst) hi)
         (keys-in-range lo hi (int-node-left bst))]))

(keys-in-range 3 7 test-bst)
