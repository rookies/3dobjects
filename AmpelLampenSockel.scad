$fn=400;
difference() {
    union() {
        /*
         * Hauptteil
         *  35mm Durchmesser
         *  27mm Höhe
        */
        cylinder(d=35,h=27,center=true);
        /*
         * Sockel
         *  mittig unten am Hauptteil
         *  50mm Durchmesser
         *  5mm Höhe
        */
        translate([0,0,-16]) cylinder(d=50,h=5,center=true);
    }
    /*
     * Befestigungsgewinde für den Hauptteil
     *  Zentrum 21mm unter der Oberkante des Hauptteils
    */
    /* TODO: Tiefe & Durchmesser? */
    translate([0,12.75,-7.5]) rotate([90,0,0]) cylinder(d=3,h=10,center=true);
    /*
    */
    /*
     * Loch für die Lampenhalterung
     *  ganz oben am Hauptteil
     *  19mm Durchmesser
     *  10mm tief
    */
    translate([0,0,8.5]) cylinder(d=19,h=10,center=true);
    /*
     * Befestigungsgewinde für die Lampenhalterung
     *  Zentrum 6mm außerhalb der Hauptteil-Rotationsachse
    */
    /* TODO: Tiefe & Durchmesser? */
    translate([6,0,1]) cylinder(d=2,h=5,center=true);
    translate([-6,0,1]) cylinder(d=2,h=5,center=true);
    /*
     * Loch für das Kabel
     *  mittig komplett durch Sockel & Hauptteil
     *  9mm Durchmesser
    */
    cylinder(d=9,h=100,center=true);
}