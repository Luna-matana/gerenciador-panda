-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 24-Nov-2020 às 16:33
-- Versão do servidor: 8.0.22-0ubuntu0.20.04.2
-- versão do PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `mydb`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `items`
--

CREATE TABLE `items` (
  `id` int NOT NULL,
  `name` varchar(45) COLLATE utf8_esperanto_ci NOT NULL,
  `barCode` varchar(45) COLLATE utf8_esperanto_ci NOT NULL,
  `image` longblob,
  `value` float DEFAULT NULL,
  `lots_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_esperanto_ci;

--
-- Extraindo dados da tabela `items`
--

INSERT INTO `items` (`id`, `name`, `barCode`, `image`, `value`, `lots_id`) VALUES
(1, 'Café', '1234567890987', '', 10, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `item_requests`
--

CREATE TABLE `item_requests` (
  `item_id` int NOT NULL,
  `request_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_esperanto_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `lots`
--

CREATE TABLE `lots` (
  `id` int NOT NULL,
  `amount` float NOT NULL,
  `purchaseValue` float NOT NULL,
  `expiration` date NOT NULL,
  `unity` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `lots`
--

INSERT INTO `lots` (`id`, `amount`, `purchaseValue`, `expiration`, `unity`) VALUES
(1, 100, 200, '2020-11-11', 'Kg');

-- --------------------------------------------------------

--
-- Estrutura da tabela `requests`
--

CREATE TABLE `requests` (
  `id` int NOT NULL,
  `users_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `requests`
--

INSERT INTO `requests` (`id`, `users_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `sales`
--

CREATE TABLE `sales` (
  `id` int NOT NULL,
  `paymentForm` int NOT NULL,
  `description` varchar(200) NOT NULL,
  `value` float NOT NULL,
  `request_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `stocks`
--

CREATE TABLE `stocks` (
  `id` int NOT NULL,
  `amount` int NOT NULL,
  `item_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `stocks`
--

INSERT INTO `stocks` (`id`, `amount`, `item_id`) VALUES
(1, 100, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'adm', 'adm');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_items_lots1_idx` (`lots_id`);

--
-- Índices para tabela `item_requests`
--
ALTER TABLE `item_requests`
  ADD PRIMARY KEY (`item_id`,`request_id`),
  ADD KEY `fk_item_has_pedidos_pedidos1_idx` (`request_id`),
  ADD KEY `fk_item_has_pedidos_item1_idx` (`item_id`);

--
-- Índices para tabela `lots`
--
ALTER TABLE `lots`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_requests_users1_idx` (`users_id`);

--
-- Índices para tabela `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`,`request_id`),
  ADD KEY `fk_venda_pedidos1_idx` (`request_id`);

--
-- Índices para tabela `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_estoque_produto1_idx` (`item_id`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `items`
--
ALTER TABLE `items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `lots`
--
ALTER TABLE `lots`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `requests`
--
ALTER TABLE `requests`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `stocks`
--
ALTER TABLE `stocks`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `fk_items_lots1` FOREIGN KEY (`lots_id`) REFERENCES `lots` (`id`);

--
-- Limitadores para a tabela `item_requests`
--
ALTER TABLE `item_requests`
  ADD CONSTRAINT `fk_item_has_pedidos_item1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  ADD CONSTRAINT `fk_item_has_pedidos_pedidos1` FOREIGN KEY (`request_id`) REFERENCES `requests` (`id`);

--
-- Limitadores para a tabela `requests`
--
ALTER TABLE `requests`
  ADD CONSTRAINT `fk_requests_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);

--
-- Limitadores para a tabela `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `fk_venda_pedidos1` FOREIGN KEY (`request_id`) REFERENCES `requests` (`id`);

--
-- Limitadores para a tabela `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `fk_estoque_produto1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
