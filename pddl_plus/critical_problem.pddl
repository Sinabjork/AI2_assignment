(define (problem critical-injury) 
    (:domain sar-plus)
    (:objects 
        rob1 - robot
        vic1 - victim
        start-loc injury-site hospital - location
        minor-bleed - diagnosis
        bandage - treatment
    )

    (:init
        ; Location
        (at rob1 start-loc)
        (victim-at vic1 injury-site)
        (evacuation-point hospital)
        (connected start-loc injury-site)
        (connected injury-site hospital)
        
        ; Distances
        (= (distance start-loc injury-site) 10)
        (= (distance injury-site start-loc) 10)
        (= (distance injury-site hospital) 10)
        (= (distance hospital injury-site) 10)

        ; Victim Medical Status
        (has-diagnosis vic1 major-bleed)
        (needs-treatment major-bleed tourniquet)
        (= (health vic1) 90)
        (= (worsening-rate vic1) 6)

        ; Process Initialization
        (= (move-progress rob1) 0)
        (= (stabilization-progress vic1) 0)
    )

    (:goal
        (and
            (evacuated vic1)
            (not (health-failure vic1))
        )
    )

    (:metric maximize (health vic1))
)