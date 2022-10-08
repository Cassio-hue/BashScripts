#! bin/bash

# Limpa o terminal
clear

CURRENT_DIR=$(pwd)

echo -n "Qual o nome do projeto em react? "
# Ler o nome do projeto
read PROJECT_NAME
echo
echo -n "Local atual:" $CURRENT_DIR
echo
cd ~
echo -n "Local ~: "
pwd
cd $CURRENT_DIR
echo
echo -n "Onde o projeto deve ser criado? "
# Ler o local do projeto
read PROJECT_LOCAL

if !(cd $PROJECT_LOCAL); then
    exit 1
fi

# Cria um projeto react usando o vite
echo | npm create vite@latest $PROJECT_NAME -- --template react

# Entra na pasta do projeto
cd $PROJECT_NAME

# Instala as dependências e cria a node_modules
npm install

# Instalamos o prettier
npm install -D prettier

# Criamos o arquivo de configuração do prittier
PRETTIER_CONFIG='
{
  "trailingComma": "es5",
  "tabWidth": 2,
  "semi": false,
  "singleQuote": true
}
'
echo "$PRETTIER_CONFIG" > .prettierrc

# Instalamos o eslint e alguns plugins
npm install -D eslint eslint-config-prettier eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-react

# Define uma variavel que guarda as configurações do eslint
eslintrc='
{
  "extends": [
    "eslint:recommended",
    "plugin:import/errors",
    "plugin:react/recommended",
    "plugin:jsx-a11y/recommended",
    "prettier"
  ],
  "plugins": ["react", "jsx-a11y", "import"],
  "rules": {
    "react/prop-types": "off",
    "react/jsx-uses-react": "off",
    "react/react-in-jsx-scope": "off",
    "react/self-closing-comp": "warn"
  },
  "parserOptions": {
    "ecmaVersion": 2022,
    "sourceType": "module",
    "ecmaFeatures": {
      "jsx": true
    }
  },
  "env": {
    "es6": true,
    "browser": true,
    "node": true
  },
  "settings": {
    "react": {
      "version": "detect"
    },
  "import/resolver": {
      "node": {
        "extensions": [".js", ".jsx", ".ts", ".tsx"],
        "moduleDirectory": ["node_modules", "src/"]
      }
    }
  }
}
'
# Cria o arquivo de configuração do eslint
echo "$eslintrc" > .eslintrc.json

# Abre o projeto no vscode
code .