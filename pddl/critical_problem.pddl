(define (problem critical-injury)
  (:domain search-and-rescue)
  (:objects 
    rob1 - robot
    vic1 - victim
    start injury-site hospital - location
    major-bleed - diagnosis
    tourniquet - treatment
    critical serious moderate stable - health-level
  )
  (:init
    ; Location
    (at rob1 start)
    (victim-at vic1 injury-site)
    (evacuation-point hospital)
    (connected start injury-site)
    (connected injury-site hospital)

    ; Victim Medical Status
    (has-diagnosis vic1 major-bleed)
    (needs-treatment major-bleed tourniquet)
    (victim-health vic1 critical)
    (next-health-level critical serious)
    (next-health-level serious moderate)
    (next-health-level moderate stable)
    (is-stabilized stable)
  )
  (:goal (victim-at vic1 hospital))
)