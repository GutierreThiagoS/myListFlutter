
enum NavigationSelected {

  shoppingProduct(position: 0, title: "Produtos"),
  todoView(position: 1, title: "Lembretes"),
  configView(position: 2, title: "Config");

  const NavigationSelected({required this.position, required this.title});

  final int position;
  final String title;
}