;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Q3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define-struct tournament (winner round))
;; A Tournament is a (make-tournament Str Round)
;; requires: winner is the name of the player with the best time
;;	in the topmost round

;; A Round is a (listof Player)

(define-struct player (name time last-round))
;; A Player is a (make-player Str Num Round)
;; requires: time > 0
;; name is the player with the best time in the topmost round of last-round if it is non-empty

(define cs135-cup
(make-tournament "Paul"
(list (make-player "Dave" 12.3 (list (make-player "Troy" 13.1 empty)
(make-player "Dave" 11 empty)))
(make-player "Ian" 16.9 (list (make-player "Ian" 15.1 empty)
(make-player "Craig" 15.8 empty)
(make-player "Byron" 18.3 empty)))
(make-player "Paul" 12.1 (list (make-player "Paul" 19.9 empty)
(make-player "Dustin" 9999 empty))))))


;; tournament-template: Tournament → Any  (define (tournament-template tourn)
(. . . (tournament-winner tourn). . .
(round-template (tournament-round tourn)). . . )


;; round-template: Round → Any  (define (round-template round)
(cond
[(empty? round) . . . ]
[else (. . . (player-template (first round)). . .
(round-template (rest round)). . . )]))

;; player-template: Player → Any  (define (player-template pl)
(. . . (player-name pl). . .  (player-time pl). . .
(round-template (player-last-round pl)). . . )


(define-struct record (name time))
;; A Record is a (make-record Str Num)
;; requires: time > 0


;; new-record: Record Tournament → (anyof Record false)
(define (new-record rec tourn)  (local
[(define tourn-record
(new-record/round (tournament-round tourn) rec))]  (cond
[(< (record-time tourn-record) (record-time rec)) tourn-record]  [else false])))


;; new-record/round: Round Record → Record
(define (new-record/round round record-so-far)  (cond
[(empty? round) record-so-far]  [else (local
[(define round-record
(new-record/player (first round) record-so-far))]  (cond
[(< (record-time round-record) (record-time record-so-far))  (new-record/round (rest round) round-record)]
[else (new-record/round (rest round) record-so-far)]))]))


;; new-record/player: Player Record → Record
(define (new-record/player pl record-so-far)  (new-record/round (player-last-round pl)
(cond
[(< (player-time pl) (record-time record-so-far))  (make-record (player-name pl) (player-time pl))]  [else record-so-far])))