import 'package:my_list_flutter/domain/model_entity/category.dart';
import 'package:my_list_flutter/domain/model_entity/product.dart';

List<Product> products = [
  Product(
      null,
      "Arroz 1kg",
      "https://propao.agilecdn.com.br/2315_1.jpg?v=27-246342608",
      "Tio João",
      1,
      // Suponhamos que a categoria "Alimento" tenha id 1
      "1234567890123",
      5.99),
  Product(null, "Leite Integral 1L",
      "https://propao.agilecdn.com.br/5120_1.jpg?v=27-246342608",
      "Betânia", 6,
      "2345678901234", 3.49),
// ... adicione mais produtos aqui
  Product(
      null,
      "Sabonete Líquido 250ml",
      "https://cdn.ultrafarma.com.br/static/produtos/814973/large-638089531645820464-814973_6.jpg",
      "Dove",
      2,
      // Suponhamos que a categoria "Higiene" tenha id 2
      "3456789012345",
      2.99),
  Product(null, "Óleo de Soja 900ml", "https://www.drogarianet.com.br/media/product/4e3/oleo-de-soja-tipo-1-900ml-liza-1d5.jpg", "Liza", 1,
      "4567890123456", 2.99),
  Product(null, "Frango Congelado 1kg", "https://www.sadia.com.br/assets/images/_/products/e71b89216642af16a23e41675724ee7ed76b17fb.png", "Sadia", 1,
      "5678901234567", 10.99),
  Product(
      null,
      "Maçã - 1 unidade",
      "https://feelgoodpal.com/blog/how-long-do-apples-last/feature_hu42d22c423e5b513dc50352d3614c0592_341955_720x414_fill_q45_box_smart1.jpg",
      "Fazenda Feliz",
      10,
      // Suponhamos que a categoria "Frutas" tenha id 2
      "6789012345678",
      1.49),
  Product(
      null,
      "Pão de Forma - 500g",
      "url_pao.png",
      "Wickbold",
      3,
      // Suponhamos que a categoria "Padaria" tenha id 3
      "7890123456789",
      3.29),
  Product(
      null,
      "Detergente Líquido 500ml",
      "url_detergente.png",
      "Ypê",
      4,
      // Suponhamos que a categoria "Limpeza" tenha id 5
      "9012345678901",
      1.89),
  Product(null, "Champô 400ml", "url_shampoo.png", "Pantene", 4,
      "0123456789012", 8.99),
  Product(
      null,
      "Leite Condensado 395g",
      "https://naturaldaterra.com.br/media/catalog/product/1/1/111330---7891000065440---leite-cond-moca-trad-caixa-nestle-395g.jpg?auto=webp&format=pjpg&width=1600&height=2000&fit=cover",
      "Nestlé",
      6,
      // Suponhamos que a categoria "Leites e Derivados" tenha id 6
      "1234567890123",
      3.79),
  Product(null, "Iogurte Natural 200g", "https://img.sitemercado.com.br/produtos/e963c8eb2134f418a08d2297fef1a4c4a4de763ba8859a174ca31eb0aa6558cf_full.jpg", "Danone", 6,
      "2345678901234", 1.29),
  Product(
      null,
      "Café em Pó 250g",
      "url_cafe.png",
      "3 Corações",
      7,
      // Suponhamos que a categoria "Bebidas" tenha id 7
      "3456789012345",
      8.99),
  Product(null, "Refrigerante Cola 2L", "url_refrigerante.png", "Coca-Cola", 7,
      "4567890123456", 4.49),
  Product(null, "Pasta de Dentes 100g", "url_pasta_dentes.png", "Colgate", 4,
      "5678901234567", 2.99),
  Product(null, "Sabão em Pó 1kg", "url_sabao_po.png", "Omo", 4,
      "6789012345678", 7.79),
  Product(
      null,
      "Batata Chips 100g",
      "url_batata_chips.png",
      "Ruffles",
      7,
      // Suponhamos que a categoria "Snacks" tenha id 7
      "7890123456789",
      3.99),
  Product(
      null,
      "Creme de Avelã 200g",
      "url_creme_avela.png",
      "Nutella",
      8,
      // Suponhamos que a categoria "Doces" tenha id 8
      "8901234567890",
      10.59),
  Product(
      null,
      "Espaguete 500g",
      "url_espaguete.png",
      "Barilla",
      9,
      // Suponhamos que a categoria "Massas" tenha id 9
      "9012345678901",
      2.29),
  Product(null, "Creme Dental 150g", "url_creme_dental.png", "Sensodyne", 2,
      "0123456789012", 4.99),
  Product(null, "Baguete 250g", "https://panutti.com.br/resize/imagecache//7037dbd08a00f7cd5f882c810b7fe9d0.jpg", "Panificadora Delícia", 3,
      "1234567890123", 2.29),
  Product(null, "Desinfetante 500ml", "url_desinfetante.png", "Veja", 4,
      "2345678901234", 3.89),
  Product(null, "Água Mineral 1,5L", "url_agua.png", "Crystal", 5,
      "3456789012345", 1.99),
  Product(null, "Manteiga 200g", "https://tdc08h.vteximg.com.br/arquivos/ids/169313-1000-1000/1097505-manteiga-qualy-200g-com-sal-g.jpg?v=637789745922730000", "Qualy", 6,
      "4567890123456", 5.49),
  Product(null, "Cookies 150g", "url_cookies.png", "Nestlé", 7, "5678901234567",
      3.79),
  Product(null, "Chocolate ao Leite 100g", "url_chocolate.png", "Lacta", 8,
      "6789012345678", 4.99),
  Product(null, "Queijo Mussarela 250g", "https://boa.vtexassets.com/unsafe/fit-in/720x720/center/middle/https%3A%2F%2Fboa.vtexassets.com%2Farquivos%2Fids%2F436354%2FQueijo-Mucarela-Tirolez-Aperitivo-kg.jpg%3Fv%3D638388569152600000", "Tirolez", 6,
      "7890123456789", 7.99),
  Product(null, "Macarrão Penne 500g", "url_macarrao.png", "Barilla", 9,
      "8901234567890", 1.49),
  Product(null,
      "Banana - 1 unidade",
      "https://redemix.vteximg.com.br/arquivos/ids/205964-1000-1000/1129.jpg?v=638350587402600000",
      "Fazenda Feliz",
      10,
      "9012345678901",
      0.89
  ),

  Product(
      null,
      "Macarrão Instantâneo",
      "https://www.varanda.com.br/media/catalog/product/cache/1/image/600x/9df78eab33525d08d6e5fb8d27136e95/m/a/mac-inst-nissin-lamen-gal-caip-85g-7891079000229.jpg",
      "Nissin",
      9,
      "9012345678901",
      2.29),
];

List<Category> categories = [
  Category(1, "Alimento"),
  Category(2, "Higiene"),
  Category(3, "Padaria"),
  Category(4, "Limpeza"),
  Category(5, "Bebidas"),
  Category(6, "Leites e Derivados"),
  Category(7, "Snacks"),
  Category(8, "Doces"),
  Category(9, "Massas"),
  Category(10, "Frutas")
];
