;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname graphs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Example of DAG
(define g1 
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

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
         (cond [(symbol=? v (first (first G))) (second (first G))]
               [else (neighbours v (rest G))])]))

;;find-path/list: (listof Node) Node Graph (listof Node) -> (anyof (list of Node) false)
(define (find-path/list nbrs dest G visited)
   (cond [(empty? nbrs) false]
         [(member? (first nbrs) visited)(find-path/list (rest nbrs) dest G visited)]
         [ else (local
                  [(define orig (first nbrs))
                   (define path (find-path/acc orig dest G visited))]
                  (cond [(false? path) (find-path/list (rest nbrs) dest G visited)]
                        [else path]
                   )
                 )
         ]
   )
)

;; find-path/acc: Node Node Graph (list of Node) -> (anyof (list of Node) false)
(define (find-path/acc orig dest G visited)
  (cond [(symbol=? orig dest) (list orig)]
        [else (local [(define nbrs (neighbours orig G))
                      (define path (find-path/list nbrs dest G (cons orig visited)))]
                (cond [(false? path) false]
                      [else (cons orig path)]))]))

;; find-path:Node Node Graph -> (anyof (list of Node) false)
;; Wrapper function
(define (find-path orig dest G)
  (local [(define path (find-path/acc orig dest G empty))]
    (cond [(false? path) false]
          [else path])))


(find-path 'A 'D g1)
(find-path 'D 'G g1)
(find-path 'B 'G g1)
(find-path 'E 'B g1)