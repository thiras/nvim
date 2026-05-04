return {
  "3rd/diagram.nvim",
  opts = function()
    -- Ubuntu 23.10+ blocks unprivileged user namespaces via AppArmor, which
    -- breaks puppeteer's Chromium sandbox. Disable it for mmdc only.
    local puppeteer_config = vim.fn.stdpath("cache") .. "/mermaid-puppeteer.json"
    vim.fn.writefile({ '{"args":["--no-sandbox"]}' }, puppeteer_config)
    return {
      renderer_options = {
        mermaid = {
          cli_args = { "--puppeteerConfigFile", puppeteer_config },
        },
      },
    }
  end,
}
