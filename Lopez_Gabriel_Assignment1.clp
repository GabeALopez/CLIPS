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
    (path (nodes A B) (cost 10))
    (path (nodes B C) (cost 5))
    (path (nodes B D) (cost 8))
    (path (nodes D E) (cost 6))
    (path (nodes E F) (cost 7)))

;the knwoledge base
(defrule indirect-paths
    (path (nodes $?begin ?temp1 $?temp2))
    (path (nodes ?temp1 $?temp2 $?end))
    =>
    (assert (path (nodes $?begin ?temp1 $?temp2 $?end))))

(defrule calculateCosts
    (path (nodes $?nodes) (cost ?cost))
    =>
    (printout t "Calculating cost for path: " $?nodes crlf)
    (bind ?newCost 0)
    (loop-for-count (?i(length ?nodes))
        (bind ?node (nth$ ?i ?nodes))
        (if (eq ?i 1)
            then (bind ?prevNode ?node)
            else (progn
                (bind ?edgeCost (getCost ?prevNode ?node)) 
                (bind ?newCost (+ ?newCost ?edgeCost))
                (bind ?prevNode ?node)
                ))
    )
    (modify ?facts (nodes $?nodes) (cost ?newCost))
)

(defrule print-paths
    (path (nodes $?nodes))
    =>
    (printout t "Path: " $?nodes crlf))