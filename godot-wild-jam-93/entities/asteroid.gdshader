shader_type canvas_item;

render_mode blend_mix;

uniform vec4 dark_color : source_color = vec4(0.15, 0.32, 0.22, 0.0);
uniform vec4 light_color : source_color = vec4(0.72, 0.68, 0.52, 0.0);
uniform float light_detail : hint_range(10.0, 200.0) = 100.0;

float random(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

float noise(vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    
    return mix(a, b, u.x) +
           (c - a) * u.y * (1.0 - u.x) +
           (d - b) * u.x * u.y;
}

float fbm(vec2 uv) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;
    for(int i = 0; i < 4; i++) {
        value += amplitude * noise(uv * frequency);
        frequency *= 2.0;
        amplitude *= 0.5;
    }
    
    return value;
}

void fragment() {
    vec4 final_color = dark_color;
    float light_noise = fbm(UV * light_detail);
    float light_anim = smoothstep(0.3, 0.7, light_noise);

    float light = light_anim;
    final_color = mix(final_color, light_color, light);
    
    COLOR = final_color;
}