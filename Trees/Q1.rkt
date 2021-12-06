;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Q1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; An Integer Binary Tree (IntBT) is one of:
;; * empty
;; * an IntNode

(define-struct int-node (key left right))
;; An IntNode is a (make-int-node Int IntBT IntBT)

(define (min-key bt)
(cond [(and (empty? (int-node-left bt))
(empty? (int-node-right bt)))  (int-node-key bt)]
[(empty? (int-node-left bt))  (min (int-node-key bt)
(min-key (int-node-right bt)))]  [(empty? (int-node-right bt))
(min (int-node-key bt)
(min-key (int-node-left bt)))]  [else (min (int-node-key bt)
(min-key (int-node-left bt))  (min-key (int-node-right bt)))]))


;; keys-in-range: Num Num BST → (listof Num)
;; requires: lo <= hi
(define (keys-in-range lo hi bst)  (cond
[(empty? bst) empty]  [(< (node-key bst) lo)
(keys-in-range lo hi (node-right bst))]
[(and (>= (node-key bst) lo) (<= (node-key bst) hi))  (append (keys-in-range lo hi (node-left bst))
(cons (node-key bst)
(keys-in-range lo hi (node-right bst))))]  [(> (node-key bst) hi)
(keys-in-range lo hi (node-left bst))]))