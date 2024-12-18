base_thickness = 1;
layer_height = 0.2;

insert_width = 5.1;
insert_length = 25.5;
knob_diameter = 2;
knob_distance = 7;

insert_height = layer_height * 2;


epsilon=0.01;


module knob(d, h) {
    cylinder(d=d, h=h, $fn=64);
}

module insert() {
    difference() {
        translate([0, 0, ((insert_height  + epsilon) / 2) - epsilon]) cube([insert_width, insert_length, insert_height + epsilon], center=true);
        union() {
            translate([0, knob_distance / 2, 0]) knob(d=knob_diameter, h=insert_height + epsilon);
            translate([0, -knob_distance / 2, 0]) knob(d=knob_diameter, h=insert_height + epsilon);
        }
    }
}


difference() {
    translate([10, 10, 0]) union() {
        color("white") linear_extrude(base_thickness) import("Relationship anarchy white.svg", center=true);
        translate([0, 0, epsilon]) color("red") linear_extrude(base_thickness + layer_height) import("Relationship anarchy red.svg", center=true);
        translate([0, 0, epsilon * 2]) color("black") linear_extrude(base_thickness + layer_height * 2) import("Relationship anarchy black.svg", center=true);
    }

    translate([10, 20, 0]) rotate([0, 0, 90]) insert();
}
