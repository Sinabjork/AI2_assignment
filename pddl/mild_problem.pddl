(define (problem mild-injury)
  (:domain search-and-rescue)
  (:objects 
    rob1 - robot
    vic1 - victim
    start injury-site hospital - location
    minor-bleed - diagnosis
    bandage - treatment
    moderate stable - health-level
  )
  (:init
    (at rob1 start)
    (victim-at vic1 injury-site)
    (evacuation-point hospital)
    (connected start injury-site)
    (connected injury-site hospital)

    (has-diagnosis vic1 minor-bleed)
    (needs-treatment minor-bleed bandage)
    
    ; Health state
    (victim-health vic1 moderate)
    (next-health-level moderate stable)
    (is-stabilized stable)
  )
  (:goal (victim-at vic1 hospital))
)