import os

# Generate 1000 tiny JS behavior files
base_dir = 'scripts/ai'
os.makedirs(base_dir, exist_ok=True)

templates = [
    ('rotate', 'bot.targetRotation += {0.05 * (i%4 -2)};'),
    ('build', 'buildStructure(bot, game, {i%3 ==0 ? "wall" : "ramp"});'),
    ('edit', 'window.raycastEdit(bot, game, {i%2==0 ? "edit" : "break"});'),
    ('move', 'bot.velocity.add(new THREE.Vector3({Math.sin(i/10)},0,{Math.cos(i/10)}).multiplyScalar(0.1));')
]

for i in range(1000):
    behavior_type, code = templates[i % len(templates)]
    filename = f'{base_dir}/behavior_{behavior_type}_{i}.js'
    content = f"""export default function {behavior_type}_{i}(bot, game) {{
    {code.format(i=i)}
}}"""
    with open(filename, 'w') as f:
        f.write(content)
    print(f'Created {filename}')

print('Done! Add paths to ai-core-fixed.js behaviors array and reload.')
