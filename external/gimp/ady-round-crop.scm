(define (ady-round-crop img drawable size radius)
  	(gimp-context-push)
	(gimp-image-undo-group-start img)
	(gimp-round-rect-select img
                                0 0
                                size size
                                radius radius
                                CHANNEL-OP-ADD
                                TRUE
                                FALSE 0 0)         
	(gimp-selection-invert img)
	(gimp-edit-clear drawable)
	(gimp-selection-none img)
	(gimp-image-undo-group-end img)
	(gimp-context-pop)
	(gimp-displays-flush)
)


(script-fu-register "ady-round-crop"
        "Round Crop"
        "Crop a layer to a rounded rectangle"
	"Lap Trip"
	"Lap Trip"
	"2010"
	"RGB*,GRAY*"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Layer" 0
        SF-VALUE "Rectangle Size"  "61"
        SF-VALUE "Corner Radius" "8"
)

(script-fu-menu-register "ady-round-crop"
	"<Image>/Image/Ady")
