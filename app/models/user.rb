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

  # 關聯
  has_many :pages
  # 關聯, 一個人可以參與很多page的編輯 - 多對多(user - sharepage(第三方) - page )
  has_many :sharepages
  has_many :linkpages, through: :sharepages, source: :page

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  private

  def confirmation_token
    self.confirm_token = [*'0'..'9'].sample(4).join if confirm_token.blank?
  end

  def init_template
    init_block_data = [{ 'id': '05Ac-bg8U8',
                         'type': 'header', 'data': { 'text': '<b>開始使用Zettel</b>', 'level': 1 } },
                       { 'id': '4_ssCOKw4Y', 'type': 'paragraph', 'data': { 'text': '選擇旁邊的<code class="inline-code"> “＋”</code>，你可以在這裡使用更多有趣的功能' } }, { 'id': 'VZQ1Cb0rlk', 'type': 'image', 'data': { 'file': { 'url': 'https://image-repo-zeltek.s3.ap-northeast-1.amazonaws.com/8856641178649' }, 'caption': '就像這樣～', 'withBorder': false, 'stretched': false, 'withBackground': false } }, { 'id': 'u4jZeOYkA6', 'type': 'paragraph', 'data': { 'text': '另外更可以透過拖動來調整段落順序' } }, { 'id': 'YJyQ7HP-9-', 'type': 'image', 'data': { 'file': { 'url': 'https://image-repo-zeltek.s3.ap-northeast-1.amazonaws.com/9690636103570' }, 'caption': '', 'withBorder': false, 'stretched': false, 'withBackground': false } }, { 'id': 'mbZUPy2YZI', 'type': 'paragraph', 'data': { 'text': '讓我們開始吧.....' } }]
    page_title = '開始使用Zettel'
    add_template(init_block_data, page_title)
  end

  def travel_template
    travel_block_data = [{ "id": 'XLGBDeE8g_', "type": 'header', "data": { "text": '<b>台南二日遊-旅遊規劃</b>', "level": 1 } },
                         { "id": 'bdaaYYE-Oa', "type": 'header', "data": { "text": '＊食＊', "level": 3 } }, { "id": 'VKkA7uXhen', "type": 'table', "data": { "withHeadings": false, "content": [%W[\u5E97\u540D \u5730\u5740], ['文章牛肉湯', '&nbsp;708台南市安平區安平路300號'], %W[\u7D05\u78DA\u5E03\u4E01 708\u53F0\u5357\u5E02\u5B89\u5E73\u5340\u5B89\u5E73\u8DEF602-1\u865F], ['方蘭川布丁', '&nbsp;708台南市安平區安北路112號']] } }, { "id": '8G4osyLFfG', "type": 'link', "data": { "link": 'https://tisshuang.tw/blog/post/tainanfoods', "meta": { "title": '台南美食(2022.8月更新)｜網友推爆的18間台南國華街必吃｜沒吃過這些等於沒來過台南｜美食地圖看這篇 @TISS玩味食尚', "description": '台南美食超多，其中又以台南國華街必吃美食最多，第一次來台南，除了著名的邱家小卷米粉之外，還有附近炸雞洋行、南都石頭烤玉米、阿松割包、金得春捲、富盛號碗稞，都是許多人必吃的排隊美食，最近還公布了2022米其林台南美食，入選包括葉家小卷米粉、大勇街無名鹹粥、阿明豬心冬粉、這篇Tiss特別收錄每間小吃google的網路評分，', "image": { "url": 'https://tisshuang.tw/wp-content/uploads/2019/01/1617952647-15828b77f27c9a968b715a93d3ff1ca3.jpg' } } } }, { "id": '86gikjyWhe', "type": 'header', "data": { "text": '＊街＊', "level": 3 } }, { "id": '6NC_xSNxeo', "type": 'paragraph', "data": { "text": '我們&nbsp;<u class="cdx-underline"><b>一定&nbsp;</b></u>要逛到這些街' } }, { "id": 'L4wCoqPxbM', "type": 'checklist', "data": { "items": [{ "text": '萬昌街', "checked": false }, { "text": '國華街', "checked": false }, { "text": '任何街都要逛', "checked": false }] } }, { "id": 'P1shnvvCTF', "type": 'image', "data": { "file": { "url": 'https://image-repo-zeltek.s3.ap-northeast-1.amazonaws.com/2517961563815' }, "caption": '所有景點地圖', "withBorder": false, "stretched": false, "withBackground": false } }]
    page_title = '旅遊規劃'
    add_template(travel_block_data, page_title)
  end

  def add_template(data_block, page_title)
    page = pages.create!(
      title: page_title
    )
    prev_blockID = nil
    data_block.map do |block|
      init_block = page.blocks.new(
        "blockID": block[:id],
        "kind": block[:type],
        "data": block[:data],
        "prev_blockID": prev_blockID
      )
      prev_blockID = block[:id]
      init_block.save
    end
    page.update(
      "tail": prev_blockID
    )
  end
end

