# local_ia

## Services

| Service         | À quoi ça sert                                                                            | Port par défaut  |
| --------------- | ----------------------------------------------------------------------------------------- | ---------------- |
| **Ollama**      | Serveur local pour exécuter des modèles LLM (ex: Llama, Mistral…) via API REST            | **11434**        |
| **Docker**      | Plateforme de conteneurisation utilisée pour faire tourner les services (ex: AnythingLLM) | N/A              |
| **AnythingLLM** | Interface web pour discuter avec tes documents, similaire à l'interface ChatGPT ou Claude | **3001**         |

## Installation
```bash
chmod +x *.sh
./system_prepare.sh
sudo ./install_docker.sh
./ollama_install.sh
./install_anythingllm.sh
```

## Tester

Pour tester, voici ce que vous pouvez faire :
- Aller sur `http://localhost:11434` pour tester la fonctionnalité d'Ollama
- Aller sur `http://localhost:3001` pour tester l'interface AnythingLLM
- Depuis l'interface AnythingLLM, connecter Ollama à AnythingLLM
