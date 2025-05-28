# 📦 Guia de Instalação - RO-AI-Bot

<div align="center">

![Installation Banner](../assets/icons/installation-banner.png)

### 🚀 Guia Completo para Instalar o RO-AI-Bot

*Do download à configuração final em poucos minutos*

</div>

---

## 📋 Pré-requisitos

Antes de começar, certifique-se de que você tem:

| Item | Descrição | Status |
|------|-----------|--------|
| 🎮 **Cliente RO** | Ragnarök Online instalado | ✅ Obrigatório |
| 📁 **Pasta AI** | Diretório `/AI/` no cliente | ✅ Obrigatório |
| 📝 **Editor de Texto** | Para editar configurações | 🔶 Recomendado |
| 💾 **Backup** | Dos arquivos AI originais | 🔶 Recomendado |

## 🎯 Métodos de Instalação

### 🚀 Método 1: Instalação Automática (Recomendado)

```bash
# 1. Clone o repositório
git clone https://github.com/bulletdev/RO-AI-Bot.git

# 2. Execute o instalador
cd RO-AI-Bot
./install.sh /caminho/para/seu/RO/
```

### 📋 Método 2: Instalação Manual

#### Passo 1: Download
1. Acesse a página de [Releases](https://github.com/bulletdev/RO-AI-Bot/releases)
2. Baixe a versão mais recente
3. Extraia o arquivo ZIP

#### Passo 2: Localizar Pasta AI
```
📁 Ragnarök Online/
├── 📁 AI/                    ← Pasta destino
│   ├── AI.lua               ← Arquivo original (backup!)
│   └── AI_M.lua             ← Arquivo original (backup!)
├── 📁 data/
├── RagexeRE.exe
└── ...
```

#### Passo 3: Backup dos Arquivos Originais
```bash
# Criar pasta de backup
mkdir AI/backup/

# Fazer backup dos arquivos originais
cp AI/AI.lua AI/backup/AI_original.lua
cp AI/AI_M.lua AI/backup/AI_M_original.lua
```

#### Passo 4: Copiar Novos Arquivos
```bash
# Copiar novos arquivos AI
cp RO-AI-Bot/AI/AI.lua /caminho/para/RO/AI/
cp RO-AI-Bot/AI/AI_M.lua /caminho/para/RO/AI/
cp -r RO-AI-Bot/AI/configs/ /caminho/para/RO/AI/
```

## 🔧 Configuração Inicial

### ⚙️ Configuração Básica

1. **Abra o arquivo de configuração:**
```bash
# Para Homunculus
notepad AI/configs/homunculus_config.lua

# Para Assistentes
notepad AI/configs/mercenary_config.lua
```

2. **Configure as opções básicas:**
```lua
-- Configuração Recomendada para Iniciantes
local Config = {
    AUTO_ATTACK = true,          -- Ataque automático
    ATTACK_RANGE = 12,           -- Alcance moderado
    FOLLOW_DISTANCE = 3,         -- Seguir de perto
    USE_SKILLS = false,          -- Desabilitar skills no início
    FLEE_HP_PERCENT = 25,        -- Fugir com 25% HP
}
```

### 🎮 Tipos de Configuração

#### 🛡️ **Configuração Defensiva**
```lua
local DefensiveConfig = {
    AUTO_ATTACK = false,
    PROTECT_OWNER = true,
    FOLLOW_DISTANCE = 2,
    FLEE_HP_PERCENT = 40,
    ASSIST_OWNER = true,
}
```

#### ⚔️ **Configuração Ofensiva**
```lua
local OffensiveConfig = {
    AUTO_ATTACK = true,
    ATTACK_RANGE = 20,
    CHASE_RANGE = 25,
    USE_SKILLS = true,
    FLEE_HP_PERCENT = 15,
}
```

#### ⚖️ **Configuração Balanceada**
```lua
local BalancedConfig = {
    AUTO_ATTACK = true,
    ATTACK_RANGE = 14,
    FOLLOW_DISTANCE = 3,
    USE_SKILLS = true,
    ASSIST_OWNER = true,
    FLEE_HP_PERCENT = 25,
}
```

## 🧪 Testando a Instalação

### 1️⃣ **Teste Básico**

1. Inicie o Ragnarök Online
2. Entre com um personagem que tem Homunculus
3. Invoque o Homunculus: `/ho`
4. Observe o comportamento

### 2️⃣ **Verificação de Funcionamento**

| Teste | Esperado | ✅/❌ |
|-------|----------|-------|
| **Seguir** | Homunculus segue o jogador | |
| **Ataque** | Ataca monstros próximos | |
| **Fuga** | Foge com HP baixo | |
| **Comandos** | Responde a `/ho` | |

### 3️⃣ **Teste Avançado**

```lua
-- Adicione esta linha para debug
DEBUG_MODE = true

-- Reinicie o jogo e observe as mensagens
```

## 🚨 Resolução de Problemas

### ❌ **Problemas Comuns**

#### Problema: "AI não funciona"
```
Soluções:
1. Verificar se os arquivos estão na pasta correta
2. Confirmar permissões de leitura
3. Reiniciar o cliente completamente
4. Verificar se não há erros de sintaxe
```

#### Problema: "Homunculus não ataca"
```
Verificações:
1. AUTO_ATTACK = true
2. ATTACK_RANGE > 0  
3. Lista de monstros não está vazia
4. Homunculus tem SP suficiente
```

#### Problema: "Conflito com AI original"
```
Solução:
1. Deletar arquivos AI antigos
2. Reinstalar completamente
3. Limpar cache do cliente
```

### 🔍 **Modo Debug**

Para ativar o modo debug:

```lua
-- No topo do arquivo AI.lua
DEBUG_MODE = true
LOG_ACTIONS = true
VERBOSE_OUTPUT = true
```

## 📱 Diferentes Tipos de Cliente

### 🌟 **Cliente Renewal**
```lua
-- Configurações específicas
RENEWAL_MODE = true
MAX_LEVEL = 175
EXTENDED_SKILLS = true
```

### 🏛️ **Cliente Classic**
```lua
-- Configurações específicas
CLASSIC_MODE = true
MAX_LEVEL = 99
BASIC_SKILLS_ONLY = true
```

### 🔄 **Cliente Zero**
```lua
-- Configurações específicas
ZERO_MODE = true
ALTERNATE_MECHANICS = true
```

## 🌍 Configuração por Servidor

### 🇰🇷 **Servidores Oficiais Coreanos**
```lua
local kROConfig = {
    LANGUAGE = "korean",
    SKILL_DELAYS = "official",
    MONSTER_IDS = "kro_database"
}
```

### 🇺🇸 **Servidores Internacionais**
```lua
local iROConfig = {
    LANGUAGE = "english", 
    SKILL_DELAYS = "renewal",
    MONSTER_IDS = "iro_database"
}
```

### 🏴‍☠️ **Servidores Privados**
```lua
local PrivateConfig = {
    CUSTOM_RATES = true,
    CUSTOM_MONSTERS = true,
    FLEXIBLE_MECHANICS = true
}
```

## 🔄 Atualizações

### 📥 **Atualizando Manualmente**

1. **Backup das configurações atuais**
```bash
cp AI/configs/ AI/backup_configs/
```

2. **Baixar nova versão**
3. **Substituir arquivos**
4. **Restaurar configurações personalizadas**

### 🤖 **Auto-Update (Futuro)**
```bash
# Recurso planejado para v2.0
./update.sh --check
./update.sh --install
```

## ✅ Checklist Pós-Instalação

- [ ] ✅ Arquivos copiados corretamente
- [ ] ✅ Backup dos originais feito
- [ ] ✅ Configurações básicas definidas
- [ ] ✅ Teste básico realizado
- [ ] ✅ Comportamento esperado observado
- [ ] ✅ Debug desabilitado (se necessário)
- [ ] ✅ Documentação lida

## 🆘 Suporte

Se você encontrar problemas durante a instalação:

1. 📖 Consulte [Troubleshooting](TROUBLESHOOTING.md)
2. 🐛 [Reporte um bug](https://github.com/bulletdev/RO-AI-Bot/issues)
3. 💬 [Discord da comunidade](https://discord.gg/ro-ai-bot)
4. 📧 [Email de suporte](mailto:support@ro-ai-bot.com)

---

<div align="center">

### 🎉 Instalação Concluída!

**Seu RO-AI-Bot está pronto para usar!**

[⬅️ Voltar ao README](../README.md) | [➡️ Configuração Avançada](CONFIGURATION.md)

</div>