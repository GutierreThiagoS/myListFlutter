import 'package:flutter/material.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
        color: Colors.black12,
        child: Column(
          children: [

            Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: 200,
                      child: Image.asset(
                        "assets/user_settings.png",
                      ),
                    ),
                    const Text(
                        "Desenvolvido por Gutierre Guimarães",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const Text("Vesão: 0.0.1"),
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: 75,
                      child: Image.asset(
                        "assets/linkedin_logo.png",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Expanded(
                  flex: 1,
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Image.asset(
                              "assets/support.png",
                            ),
                          ),
                          const Text("Suporte"),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(40),
                            child: Image.asset(
                              "assets/editar_category.png",
                            ),
                          ),
                          const Text("Editar Categoria"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )

          ],
        )
    );
  }
}
