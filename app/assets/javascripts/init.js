document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.dropdown-trigger');
    var instances = M.Dropdown.init(elems, {
      "alignment": "center",
      "coverTrigger": false,
      "closeOnClick": true,
    //   "constrainWidth": true
    });
    var elems = document.querySelectorAll('.tabs');
    var instances = M.Tabs.init(elems, {});
    var elems = document.querySelectorAll('.modal');
    var instances = M.Modal.init(elems, {});
});

function onClickAdd() {
    var modal = document.getElementById('modal1');
    var instance = M.Modal.getInstance(modal);
    instance.open();
}

function onClickTab(elm) {
    var tabs = document.getElementById('tabs1');
    var instance = M.Tabs.getInstance(tabs);
    instance.select(elm.id);
    return false;
}

function checkInputs(className) {
    if (document.getElementById(className + '-song').value == ""
        || document.getElementById(className + '-artist').value == "") {
        document.getElementsByClassName(className)[0].classList.add('disabled');
    } else {
        document.getElementsByClassName(className)[0].classList.remove('disabled');
        console.log(document.getElementsByClassName(className)[0]);
    }
}

/**
 * Animate in modal
 */
function _animateIn() {
    // Set initial styles
    $.extend(this.el.style, {
        display: 'block',
        opacity: 0
    });
    $.extend(this.$overlay[0].style, {
        display: 'block',
        opacity: 0
    });

    // Animate overlay
    anim({
        targets: this.$overlay[0],
        opacity: this.options.opacity,
        duration: this.options.inDuration,
        easing: 'easeOutQuad'
    });

    // Define modal animation options
    let enterAnimOptions = {
        targets: this.el,
        duration: this.options.inDuration,
        easing: 'easeOutCubic',
        // Handle modal onOpenEnd callback
        complete: () => {
        if (typeof this.options.onOpenEnd === 'function') {
            this.options.onOpenEnd.call(this, this.el, this._openingTrigger);
        }
        }
    };

    // Bottom sheet animation
    if (this.el.classList.contains('bottom-sheet')) {
        $.extend(enterAnimOptions, {
        bottom: 0,
        opacity: 1
        });
        anim(enterAnimOptions);

        // Normal modal animation
    } else {
        $.extend(enterAnimOptions, {
        top: [this.options.startingTop, this.options.endingTop],
        opacity: 1,
        scaleX: [0.8, 1],
        scaleY: [0.8, 1]
        });
        anim(enterAnimOptions);
    }
}

/**
 * Animate out modal
 */
function _animateOut() {
    // Animate overlay
    anim({
        targets: this.$overlay[0],
        opacity: 0,
        duration: this.options.outDuration,
        easing: 'easeOutQuart'
    });

    // Define modal animation options
    let exitAnimOptions = {
        targets: this.el,
        duration: this.options.outDuration,
        easing: 'easeOutCubic',
        // Handle modal ready callback
        complete: () => {
        this.el.style.display = 'none';
        this.$overlay.remove();

        // Call onCloseEnd callback
        if (typeof this.options.onCloseEnd === 'function') {
            this.options.onCloseEnd.call(this, this.el);
        }
        }
    };

    // Bottom sheet animation
    if (this.el.classList.contains('bottom-sheet')) {
        $.extend(exitAnimOptions, {
        bottom: '-100%',
        opacity: 0
        });
        anim(exitAnimOptions);

        // Normal modal animation
    } else {
        $.extend(exitAnimOptions, {
        top: [this.options.endingTop, this.options.startingTop],
        opacity: 0,
        scaleX: 0.8,
        scaleY: 0.8
        });
        anim(exitAnimOptions);
    }
}
