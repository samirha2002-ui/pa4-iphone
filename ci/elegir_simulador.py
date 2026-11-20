import json, sys

dispositivos = json.load(sys.stdin)["devices"]
candidatos = []
for runtime, lista in dispositivos.items():
    if "iOS" not in runtime:
        continue
    for d in lista:
        if d.get("isAvailable") and d["name"].startswith("iPhone"):
            candidatos.append((runtime, d["name"], d["udid"]))
candidatos.sort()
pro = [c for c in candidatos if "Pro" in c[1] and "Max" not in c[1]]
print((pro or candidatos)[-1][2])
