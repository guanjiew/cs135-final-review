;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Q1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define g1
  '((A (B C F))
    (B ())
    (C (A B))
    (D (A C F))
    (E (A B C))
    (F (A))))

;; neighbours: Node Graph →(listof Node)
;; produces list of neighbours of v in G
(define (neighbours v g)
  (local [(define found (filter (lambda (x) (symbol=? (first x) v)) g))]
    (cond
      [(empty? found) false]
      [else (second (first found))]
     )
   )
)
(check-expect (list 'A 'C 'F) (neighbours 'D g1))
(check-expect '() (neighbours 'B g1))
(check-expect #f (neighbours 'H g1))

;; count-in-neighbors: Graph -> (listof Nat)
;; produces a list containing the number  of in-neighboours for each node in g
(define (count-in-neighbours g)
  (map (lambda (item)
         (length (filter (lambda (neigh)
                           (member? (first item) (second neigh))) g)))
         g)
)
(check-expect (list 4 3 3 0 0 2) (count-in-neighbours g1))

;; delete-node: Node Graph -> Graph
;; delete node v if v is in g
(define (delete-node v g)
  (local[(define remove-node
           (filter (lambda (x) (not (symbol=? (first x) v))) g))
         (define remove-edges
           (map (lambda (x)
                  (list (first x)
                        (filter (lambda (y)
                                  (not (symbol=? y v))) (second x))))
                remove-node))]
    remove-edges))
(check-expect (list (list 'A (list 'B 'F)) (list 'B '()) (list 'D (list 'A 'F)) (list 'E (list 'A 'B)) (list 'F (list 'A))) (delete-node 'C g1))