; Define path template
(deftemplate path
    (multislot nodes)
    (slot cost)
)

; The fact base for paths
(deffacts direct-paths
    (path (nodes E A) (cost 1))
    (path (nodes A B) (cost 5))
    (path (nodes A C) (cost 1))
    (path (nodes C B) (cost 1))
    (path (nodes B D) (cost 1))
)

;the knowledge base for indirect paths
(defrule indirect-paths
(path (nodes $?begin ?temp) (cost ?cost1))
(path (nodes ?temp $?end) (cost ?cost2))
=>
(assert (path (nodes $?begin ?temp $?end) (cost (+ ?cost1 ?cost2) ))))

;print paths
(defrule print-paths
    (path (nodes $?nodes) (cost ?cost))
    =>
    (printout t "Path: " $?nodes " Cost: " ?cost crlf)
)

