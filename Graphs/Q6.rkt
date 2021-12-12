;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Q6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;; Viruses in a network

;; The example graph for testing
(define slides-graph 
  '((A (C D E)) (B (E J)) (C ()) (D (F J))
                (E (K)) (F (K H)) (H ()) (J (H)) (K ())))

;; (from the lecture slides)
;; neighbours: node graph -> (listof symbol)
;; produces list of neighbours of v in G
(define (neighbours v G)
  (cond
    [(empty? G) (error 'neighbours "not in graph")]
    [else
     (cond
       [(symbol=? v (first (first G))) (second (first G))]
       [else (neighbours v (rest G))])]))

;;; A. Shortest path to a client

;; shortest-to-sink/list: (ne-listof node) graph -> num
(define (shortest-to-sink/list l-nds G)
  (cond [(empty? (rest l-nds))
         (shortest-to-sink (first l-nds) G)]
        [else (min (shortest-to-sink (first l-nds) G)
                   (shortest-to-sink/list (rest l-nds) G))]))

;; shortest-to-sink: node graph -> nat
(define (shortest-to-sink orig G)
  (local [(define orig-nbrs (neighbours orig G))]
    (cond [(empty? orig-nbrs) 0]
          [else (add1 (shortest-to-sink/list orig-nbrs G))])))
"Tests for shortest-to-sink"
(= (shortest-to-sink 'A slides-graph) 1)
(= (shortest-to-sink 'K slides-graph) 0)
(= (shortest-to-sink 'D slides-graph) 2)

;;; B. Two paths diverged...

;; num-routes: node node graph -> num
(define (num-routes orig dest G)
  (cond [(symbol=? orig dest) 1]
        [else (num-routes/list (neighbours orig G) dest G)]))

;; num-routes/list: (listof node) node graph -> num
(define (num-routes/list l-nds dest G)
  (cond [(empty? l-nds) 0]
        [else (+ (num-routes (first l-nds) dest G)
                 (num-routes/list (rest l-nds) dest G))]))

;; multiple-routes?: node node graph -> boolean
(define (multiple-routes? orig dest G)
  (>= (num-routes orig dest G) 2))
"Tests for multiple-routes?"
(multiple-routes? 'D 'H slides-graph)
(not (multiple-routes? 'A 'J slides-graph))
(not (multiple-routes? 'F 'C slides-graph))
(multiple-routes? 'A 'K slides-graph)