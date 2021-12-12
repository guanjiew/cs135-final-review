;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Q5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; The example graph for testing
(define g1
  '((A (B C F))
    (B ())
    (C (A B))
    (D (A C F))
    (E (A B C))
    (F (A))))

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
(define (shortest-to-sink/list l-nds G visited)
  (cond [(empty? (rest l-nds))
         (shortest-to-sink/acc (first l-nds) G visited)]
        [(member? (first l-nds) visited) 1000]
        [else (min (shortest-to-sink/acc (first l-nds) G visited)
                   (shortest-to-sink/list (rest l-nds) G visited))]))

;; shortest-to-sink: node graph -> nat
(define (shortest-to-sink/acc orig G visited)
  (local [(define orig-nbrs (neighbours orig G))]
    (cond [(empty? orig-nbrs) 0]
          [else (add1 (shortest-to-sink/list orig-nbrs G (cons orig visited)))])))

(define (shortest-to-sink orig  G)
  (shortest-to-sink/acc orig  G '()))


"Tests for shortest-to-sink"
(check-expect (shortest-to-sink 'A g1) 1)
(check-expect (shortest-to-sink 'D g1) 0)

;;; B. Two paths diverged...

;; num-routes/list: (listof node) node graph -> num
(define (num-routes/list l-nds dest G)
  (cond [(empty? l-nds) 0]
        [else (+ (num-routes (first l-nds) dest G)
                 (num-routes/list (rest l-nds) dest G))]))

;; num-routes: node node graph -> num
(define (num-routes orig dest G)
  (cond [(symbol=? orig dest) 1]
        [else (num-routes/list (neighbours orig G) dest G)]))

;; multiple-routes?: node node graph -> boolean
(define (multiple-routes? orig dest G)
  (>= (num-routes orig dest G) 2))

"Tests for multiple-routes?"
;;(check-expect (multiple-routes? 'A 'B g1) #t)