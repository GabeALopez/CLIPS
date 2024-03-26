; Given the follow network:
; There is a directional link from A to B
; There is a directional link from B to C
; There is a directional link from B to D
; There is a directional link from D to E
; There is a directional link from E to F
; Please find and display its routing table.
;define template
(deftemplate path
    (multislot nodes)
    (slot cost))
;the fact base
(deffacts direct-paths
    (path (nodes A B))
    (path (nodes B C))
    (path (nodes B D))
    (path (nodes D E))
    (path (nodes E F)))
;the knwoledge base
(defrule indirect-paths
    (path (nodes $?begin ?temp))
    (path (nodes ?temp $?end))
    =>
    (assert (path (nodes $?begin ?temp $?end))))
(defrule print-paths
    (path (nodes $?nodes))
    =>
    (printout t "Path: " $?nodes crlf))