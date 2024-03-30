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
    (path (nodes A B) (cost 10))
    (path (nodes B C) (cost 5))
    (path (nodes B D) (cost 8))
    (path (nodes D E) (cost 6))
    (path (nodes E F) (cost 7))
)

; Indirect Paths Rule
(defrule indirect-paths
    (path (nodes $?begin $?temp1 $?temp2))
    (path (nodes $?temp1 $?temp2 $?end))
    =>
    (assert (path (nodes $?begin $?temp1 $?temp2 $?end)))
)



; Print Paths Rule
(defrule print-paths
    (path (nodes $?nodes))
    =>
    (printout t "Path: " $?nodes crlf)
)
