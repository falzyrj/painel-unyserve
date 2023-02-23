-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 22-Fev-2023 às 14:27
-- Versão do servidor: 10.4.27-MariaDB
-- versão do PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `net`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `arquivo`
--

CREATE TABLE `arquivo` (
  `id` int(11) NOT NULL,
  `nome` varchar(250) DEFAULT NULL,
  `titulo` varchar(250) DEFAULT NULL,
  `descricao` varchar(250) DEFAULT NULL,
  `botao` varchar(250) DEFAULT NULL,
  `apn` varchar(250) DEFAULT NULL,
  `imagem` varchar(250) DEFAULT NULL,
  `url` varchar(250) DEFAULT NULL,
  `file` varchar(250) DEFAULT NULL,
  `tipo` varchar(250) DEFAULT NULL,
  `operadora` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `chave`
--

CREATE TABLE `chave` (
  `id` int(11) NOT NULL,
  `chave` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `configs`
--

CREATE TABLE `configs` (
  `id` int(11) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `valor` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `config_suporte`
--

CREATE TABLE `config_suporte` (
  `id` int(11) NOT NULL,
  `id_cad` varchar(250) DEFAULT NULL,
  `SuportePaginacao` int(11) DEFAULT 10
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `icone_perfil`
--

CREATE TABLE `icone_perfil` (
  `id` int(11) NOT NULL,
  `imagem` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `imagem_perfil`
--

CREATE TABLE `imagem_perfil` (
  `id` int(11) NOT NULL,
  `imagem` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `id_cad` int(11) NOT NULL DEFAULT 0,
  `acesso` int(11) NOT NULL DEFAULT 3,
  `nome` varchar(250) DEFAULT NULL,
  `login` varchar(250) DEFAULT NULL,
  `senha` varchar(250) DEFAULT NULL,
  `senha2` varchar(250) DEFAULT NULL,
  `expiredate` varchar(250) DEFAULT NULL,
  `cota` varchar(250) NOT NULL DEFAULT '0',
  `operadora` varchar(250) DEFAULT NULL,
  `derrubado` varchar(250) DEFAULT '0',
  `bloqueado` varchar(11) NOT NULL DEFAULT 'N',
  `LimiteTeste` varchar(250) NOT NULL DEFAULT '0',
  `data` varchar(250) DEFAULT NULL,
  `ValorCobrado` varchar(250) DEFAULT NULL,
  `msginterna` longtext DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Extraindo dados da tabela `login`
--

INSERT INTO `login` (`id`, `id_cad`, `acesso`, `nome`, `login`, `senha`, `senha2`, `expiredate`, `cota`, `operadora`, `derrubado`, `bloqueado`, `LimiteTeste`, `data`, `ValorCobrado`, `msginterna`, `email`) VALUES
(1, 1, 1, 'administrador', 'admin', 'admin', '', '', '999999', 'TIM | VIVO', '0', 'N', '0', '', '10.00', '', '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `payloads`
--

CREATE TABLE `payloads` (
  `id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `FLAG` varchar(100) NOT NULL,
  `Payload` varchar(200) NOT NULL,
  `SNI` varchar(100) NOT NULL,
  `TlsIP` varchar(100) NOT NULL,
  `ProxyIP` varchar(100) NOT NULL,
  `ProxyPort` varchar(10) NOT NULL,
  `Info` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `portas`
--

CREATE TABLE `portas` (
  `id` int(11) NOT NULL,
  `Porta` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `relatorio`
--

CREATE TABLE `relatorio` (
  `id` int(11) NOT NULL,
  `id_cad` int(11) DEFAULT NULL,
  `mes` int(11) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  `usuario` int(11) DEFAULT NULL,
  `data` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `servidor`
--

CREATE TABLE `servidor` (
  `id` int(11) NOT NULL,
  `nome` varchar(250) DEFAULT NULL,
  `server` varchar(250) DEFAULT NULL,
  `porta` varchar(250) DEFAULT NULL,
  `user` varchar(250) DEFAULT NULL,
  `senha` varchar(250) DEFAULT NULL,
  `icone` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `servidores`
--

CREATE TABLE `servidores` (
  `id` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `TYPE` varchar(20) NOT NULL DEFAULT 'premium',
  `FLAG` varchar(20) NOT NULL DEFAULT 'br.png',
  `ServerIP` varchar(100) NOT NULL,
  `CheckUser` varchar(200) NOT NULL,
  `ServerPort` int(11) NOT NULL DEFAULT 22,
  `SSLPort` int(11) NOT NULL,
  `USER` varchar(20) NOT NULL,
  `PASS` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `sms`
--

CREATE TABLE `sms` (
  `id` int(11) NOT NULL,
  `login` varchar(250) DEFAULT NULL,
  `senha` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `suporte`
--

CREATE TABLE `suporte` (
  `id` int(11) NOT NULL,
  `UserEmissor` varchar(250) DEFAULT NULL,
  `UserReceptor` varchar(250) DEFAULT NULL,
  `Assunto` varchar(250) DEFAULT NULL,
  `data` varchar(250) DEFAULT NULL,
  `anexo` varchar(250) DEFAULT NULL,
  `Mensagem` longtext DEFAULT NULL,
  `LidaEmissor` varchar(11) NOT NULL DEFAULT 'N',
  `LidaReceptor` varchar(11) NOT NULL DEFAULT 'N',
  `PastaEmissor` int(11) NOT NULL DEFAULT 2,
  `PastaReceptor` int(11) NOT NULL DEFAULT 1,
  `Marcacao` int(11) NOT NULL DEFAULT 5,
  `Estrela` varchar(11) NOT NULL DEFAULT 'N',
  `ExcluirEmissor` varchar(11) NOT NULL DEFAULT 'N',
  `ExcluirReceptor` varchar(11) NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `suporteresp`
--

CREATE TABLE `suporteresp` (
  `id` int(11) NOT NULL,
  `id_suporte` int(11) DEFAULT NULL,
  `UserEmissor` varchar(250) DEFAULT NULL,
  `mensagem` longtext DEFAULT NULL,
  `anexo` varchar(250) DEFAULT NULL,
  `data` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `urlteste`
--

CREATE TABLE `urlteste` (
  `id` int(11) NOT NULL,
  `CadUser` varchar(2500) DEFAULT NULL,
  `status` varchar(11) NOT NULL DEFAULT 'N',
  `tempo` int(11) DEFAULT NULL,
  `cemail` varchar(11) NOT NULL DEFAULT 'N',
  `email` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `login` varchar(25) NOT NULL,
  `senha` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Extraindo dados da tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `login`, `senha`) VALUES
(1, 'conecta4g', 'admin', '21232f297a57a5a743894a0e4a801fc3');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `arquivo`
--
ALTER TABLE `arquivo`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `chave`
--
ALTER TABLE `chave`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `configs`
--
ALTER TABLE `configs`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `config_suporte`
--
ALTER TABLE `config_suporte`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `icone_perfil`
--
ALTER TABLE `icone_perfil`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `imagem_perfil`
--
ALTER TABLE `imagem_perfil`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `payloads`
--
ALTER TABLE `payloads`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `portas`
--
ALTER TABLE `portas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `relatorio`
--
ALTER TABLE `relatorio`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `servidor`
--
ALTER TABLE `servidor`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `servidores`
--
ALTER TABLE `servidores`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `sms`
--
ALTER TABLE `sms`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `suporte`
--
ALTER TABLE `suporte`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `suporteresp`
--
ALTER TABLE `suporteresp`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `urlteste`
--
ALTER TABLE `urlteste`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `arquivo`
--
ALTER TABLE `arquivo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `chave`
--
ALTER TABLE `chave`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `configs`
--
ALTER TABLE `configs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `config_suporte`
--
ALTER TABLE `config_suporte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `icone_perfil`
--
ALTER TABLE `icone_perfil`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `imagem_perfil`
--
ALTER TABLE `imagem_perfil`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT de tabela `payloads`
--
ALTER TABLE `payloads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `portas`
--
ALTER TABLE `portas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `relatorio`
--
ALTER TABLE `relatorio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `servidor`
--
ALTER TABLE `servidor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `servidores`
--
ALTER TABLE `servidores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `sms`
--
ALTER TABLE `sms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `suporte`
--
ALTER TABLE `suporte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `suporteresp`
--
ALTER TABLE `suporteresp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `urlteste`
--
ALTER TABLE `urlteste`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
