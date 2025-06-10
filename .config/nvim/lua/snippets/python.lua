local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
    s("pygameclass", {
        t({
            "import pygame",
            "",
            "class Game:",
            "    def __init__(self, width=800, height=600, title=\"Example Game\"):",
            "        pygame.init()",
            "        self.screen = pygame.display.set_mode((width, height))",
            "        pygame.display.set_caption(title)",
            "        self.clock = pygame.time.Clock()",
            "        self.running = True",
            "",
            "    def handle_events(self):",
            "        for event in pygame.event.get():",
            "            if event.type == pygame.QUIT:",
            "                self.running = False",
            "",
            "    def update(self):",
            "        pass",
            "",
            "    def draw(self):",
            "        self.screen.fill((30, 30, 30))",
            "        pygame.display.flip()",
            "",
            "    def run(self):",
            "        while self.running:",
            "            self.handle_events()",
            "            self.update()",
            "            self.draw()",
            "            self.clock.tick(60)",
            "",
            "        pygame.quit()",
            "",
            "if __name__ == \"__main__\":",
            "    game = Game()",
            "    game.run()",
        }),
    }),
}
