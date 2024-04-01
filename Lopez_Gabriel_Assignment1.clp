; Given the follow network:
; There is a directional link from A to B
; There is a directional link from B to C
; There is a directional link from B to D
; There is a directional link from D to E
; There is a directional link from E to F
; Please find and display its routing table.

; Define template
(deftemplate path
    (multislot nodes)
    (slot cost)
)

; The fact base
(deffacts direct-paths
    (path (nodes E A) (cost 1))
    (path (nodes A B) (cost 5))
    (path (nodes A C) (cost 1))
    (path (nodes C B) (cost 1))
    (path (nodes B D) (cost 1))
)

;the knwoledge base
(defrule indirect-paths
(path (nodes $?begin ?temp) (cost ?cost1))
(path (nodes ?temp $?end) (cost ?cost2))
=>
(assert (path (nodes $?begin ?temp $?end) (cost (+ ?cost1 ?cost2) ))))

(defrule print-paths
    (path (nodes $?nodes) (cost ?cost))
    =>
    (printout t "Path: " $?nodes " Cost: " ?cost crlf)
)

