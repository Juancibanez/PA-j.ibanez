function setup() {
    createCanvas(windowWidth, windowHeight);
    noLoop(); // Draw only once
}

function draw() {
    background(255); // Set background to white
    let numCircles = 100; // Number of circles to draw

    for (let i = 0; i < numCircles; i++) {
        let x = random(width); // Random x position
        let y = random(height); // Random y position
        let diameter = random(10, 100); // Random diameter between 10 and 100
        fill(random(255), random(255), random(255), 150); // Random color with some transparency
        noStroke(); // No outline
        ellipse(x, y, diameter, diameter); // Draw the circle
    }
}