;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Q2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; (dedup lst) produces a list that has all the duplicates removed from lst
;; dedup: (listof X) ->(listof X)
(define (dedup lst)
  (foldr (lambda (x y)
           (cond [(member? x y) y]
                 [else (cons x y)]))
         empty lst))

;; neighbours: Node Graph →(listof Node)
(define (neighbours v g)
  (cond [(empty? g) empty] 
        [(symbol=? v (first (first g))) (second (first g))]
        [else (neighbours v (rest g))]))

;; graph-union: Graph Graph →Graph
(define (graph-union g1 g2)
  (local [(define g1-nodes (map first g1))
          (define g2-nodes (map first g2))]
    (map (lambda (node)
           (list node
                 (dedup (append (neighbours node g1)
                                (neighbours node g2)))))
         (dedup (append g1-nodes g2-nodes)))))

(define g1 '((A (B))
              (B ())))

(define g2  '((A (B C))
               (B (A C))
               (C (A))))

(define g3 '((A (B C))
             (B (A C))
             (C (A))))
(check-expect (graph-union g1 g2) g3 )