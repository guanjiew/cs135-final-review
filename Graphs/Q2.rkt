;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Q2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Example of DAG
(define g1 
  '((1 (2))
    (2 (3 4))
    (3 (4 5 7))
    (4 (2 5))
    (5 (6 7))
    (6 (7))
    (7 ())))

;; A Node is a Sym

;; A Graph is one of :
;; * empty
;; * (cons (list v (list w_1 w_2 ... w_n) ) G)
;; where G is a Graph, v, w1 ... w_n are Node
;; w_1, .., w_n is the out neighbor of v

;; neighbours: Node Graph →(listof Node)
;;produces list of neighbours of v in G
(define (neighbours v G)
  (cond [(empty? G) (error "vertex not in graph")]
        [else
         (cond [(= v (first (first G))) (second (first G))]
               [else (neighbours v (rest G))])]))

;;find-trip/list: (listof Node) Node Graph (listof Node) -> (anyof Nat false)
(define (find-trip/list nbrs dest G visited)
   (cond [(empty? nbrs) false]
         [(member? (first nbrs) visited)
          (find-trip/list (rest nbrs) dest G visited)]
         [else (local
                  [(define difficulty-first (find-trip/acc (first nbrs) dest G visited))
                   (define difficulty-rest  (find-trip/list (rest nbrs) dest G visited))]
                   (cond [(false? difficulty-first) difficulty-rest]
                         [(false? difficulty-rest)  difficulty-first]
                         [else (min difficulty-first difficulty-rest)]
                   )
                )
          ]
   )
)

;; find-trip/acc: Node Node Graph (list of Node) -> (anyof Nat false)
(define (find-trip/acc orig dest G visited)
  (cond [(= orig dest) dest]
        [else (local [(define nbrs (neighbours orig G))
                      (define difficulty (find-trip/list nbrs dest G (cons orig visited)))]
                (cond [(false? difficulty) false]
                      [else (+ orig difficulty)]))]))

;; easiest-trip: Node Node Graph -> (anyof Nat false)
;; Wrapper function
(define (easiest-trip orig dest G)
  (find-trip/acc orig dest G empty))


(easiest-trip 1 6 g1)
