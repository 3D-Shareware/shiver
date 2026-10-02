shader_type spatial;

uniform sampler2D noise;
uniform float height_mult;

void vertex() {
	float height = texture(noise, UV).x * height_mult;
	VERTEX.y += height;
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
