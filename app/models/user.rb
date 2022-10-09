class User < ApplicationRecord
    before_create :confirmation_token
    after_create  :init_template, :travel_template
  
    # 加密
    require 'bcrypt'
    has_secure_password
  
    # 驗證
    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :password_digest, presence: true
  
    # 關聯, 一個人可以參與很多page的編輯 - 多對多(user - sharepage(第三方) - page )
    has_many :sharepages
    has_many :pages, through: :sharepages
  
    def email_activate
      update(email_confirmed: true, confirm_token: nil)
    end
  
    private
  
    def confirmation_token
      self.confirm_token = [*'0'..'9'].sample(4).join if confirm_token.blank?
    end
  
    def init_template
      init_block_data = [{ "id": '05Ac-bg8U8', "type": 'header', "data": { "text": '<b>Getting Started</b>', "level": 2 } },
        { "id": 'YiCX7qEQ-P', "type": 'paragraph', "data": { "text": 'Here are the basics:' } }, { "id": 'RiH3nemgq2', "type": 'checklist', "data": { "items": [{ "text": 'Click anywhere and just start typing', "checked": false }] } }, { "id": '6QJEJxvRe2', "type": 'checklist', "data": { "items": [{ "text": 'Hit <code class="inline-code">Tab</code>&nbsp;to see all the types of content you can add - headers, videos, sub pages, etc.', "checked": false }] } }, { "id": 'mr0x9kQQDV', "type": 'image', "data": { "file": { "url": 'https://image-repo-zeltek.s3.ap-northeast-1.amazonaws.com/8364854192866' }, "caption": '', "withBorder": false, "stretched": false, "withBackground": false } }, { "id": 'WCzXT69C9C', "type": 'checklist', "data": { "items": [{ "text": 'Highlight any text, and use the menu that pops up to <b>style</b> <i>your</i> <u class="cdx-underline">writing</u> <mark class="cdx-marker">however you like.</mark>', "checked": false }] } }, { "id": 'J4m08hv3Ez', "type": 'image', "data": { "file": { "url": 'https://image-repo-zeltek.s3.ap-northeast-1.amazonaws.com/7653934063513' }, "caption": '', "withBorder": false, "stretched": false, "withBackground": false } }, { "id": '9UjYLDvsLq', "type": 'checklist', "data": { "items": [{ "text": 'See the&nbsp;<code class="inline-code">⋮⋮</code> to the left of this checkbox on hover? Click and drag to move this line', "checked": false }] } }, { "id": 'pEyK887ZFo', "type": 'image', "data": { "file": { "url": 'https://image-repo-zeltek.s3.ap-northeast-1.amazonaws.com/7080027440270' }, "caption": '', "withBorder": false, "stretched": false, "withBackground": false } }, { "id": 'ybrxSy6097', "type": 'checklist', "data": { "items": [{ "text": 'Click the <code class="inline-code">+ New Page</code> button at the bottom of your sidebar to add a new page', "checked": false }, { "text": 'Click <code class="inline-code">Templates</code> in your sidebar to get started with pre-built pages', "checked": false }] } }]
      page_title = 'Welcome to Zettel'
      page_icon = "📖"
      add_template(init_block_data, page_title, page_icon)
    end
  
    def travel_template
      travel_block_data = [{ "id": 'XLGBDeE8g_', "type": 'header', "data": { "text": '<b>台南二日遊-旅遊規劃</b>', "level": 1 } },
                           { "id": 'bdaaYYE-Oa', "type": 'header', "data": { "text": '＊食＊', "level": 3 } }, { "id": 'VKkA7uXhen', "type": 'table', "data": { "withHeadings": false, "content": [%W[\u5E97\u540D \u5730\u5740], ['文章牛肉湯', '&nbsp;708台南市安平區安平路300號'], %W[\u7D05\u78DA\u5E03\u4E01 708\u53F0\u5357\u5E02\u5B89\u5E73\u5340\u5B89\u5E73\u8DEF602-1\u865F], ['方蘭川布丁', '&nbsp;708台南市安平區安北路112號']] } }, { "id": '8G4osyLFfG', "type": 'link', "data": { "link": 'https://tisshuang.tw/blog/post/tainanfoods', "meta": { "title": '台南美食(2022.8月更新)｜網友推爆的18間台南國華街必吃｜沒吃過這些等於沒來過台南｜美食地圖看這篇 @TISS玩味食尚', "description": '台南美食超多，其中又以台南國華街必吃美食最多，第一次來台南，除了著名的邱家小卷米粉之外，還有附近炸雞洋行、南都石頭烤玉米、阿松割包、金得春捲、富盛號碗稞，都是許多人必吃的排隊美食，最近還公布了2022米其林台南美食，入選包括葉家小卷米粉、大勇街無名鹹粥、阿明豬心冬粉、這篇Tiss特別收錄每間小吃google的網路評分，', "image": { "url": 'https://tisshuang.tw/wp-content/uploads/2019/01/1617952647-15828b77f27c9a968b715a93d3ff1ca3.jpg' } } } }, { "id": '86gikjyWhe', "type": 'header', "data": { "text": '＊街＊', "level": 3 } }, { "id": '6NC_xSNxeo', "type": 'paragraph', "data": { "text": '我們&nbsp;<u class="cdx-underline"><b>一定&nbsp;</b></u>要逛到這些街' } }, { "id": 'L4wCoqPxbM', "type": 'checklist', "data": { "items": [{ "text": '萬昌街', "checked": false }, { "text": '國華街', "checked": false }, { "text": '任何街都要逛', "checked": false }] } }, { "id": 'P1shnvvCTF', "type": 'image', "data": { "file": { "url": 'https://image-repo-zeltek.s3.ap-northeast-1.amazonaws.com/2517961563815' }, "caption": '所有景點地圖', "withBorder": false, "stretched": false, "withBackground": false } }]
      page_title = '旅遊規劃'
      add_template(travel_block_data, page_title)
    end
  
    def add_template(data_block, page_title, page_icon = nil)
      page = Page.create!(
        title: page_title,
        icon: page_icon
      )
      prev_blockID = nil
      data_block.map do |block|
        init_block = page.blocks.new(
          blockID: block[:id],
          kind: block[:type],
          data: block[:data],
          prev_blockID:
        )
        prev_blockID = block[:id]
        init_block.save
      end
      page.update(
        tail: prev_blockID
      )
      Sharepage.create!(user_id: id, page_id: page.id)
    end
  end
  