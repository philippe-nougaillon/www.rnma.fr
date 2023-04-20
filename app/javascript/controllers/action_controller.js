import { Controller } from "stimulus"

export default class extends Controller {
    static targets = [ "source", "selector" ]

    initialize() {
        this.toggle();
    }

    connect() {
        //console.log("Hello, Stimulus!", this.element)
    }

    click() {
        this.toggle();
    }

    toggle(){
        var check_boxes = this.sourceTargets;
        var enabled = check_boxes.filter(myFunction);
        
        function myFunction(value, index, array) {
          return value.checked;
        } 
 
        //console.log(`Clicks = ${enabled.length}`)
        var my_selector = this.selectorTarget
        
        if (enabled.length > 0 ) {
            my_selector.style.visibility = "visible";
        } else {
            my_selector.style.visibility = "hidden";
        }
    }
}