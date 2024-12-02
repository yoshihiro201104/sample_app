class ListsController < ApplicationController
  def new
    # Viewへ渡すためのインスタンス変数にからのModelオブジェクトを生成する。
    @list = List.new
  end

  def index
    @lists = List.all
  end

  # 以下を追加
  def create
    #1. データを受け取り新規登録するためのインスタンス作成
    @list = List.new(list_params)
    #２．データをデータベースに保存するためのsaveメソッド実行
    if @list.save
      #３，フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] ="投稿に成功しました。"
      redirect_to list_path(@list.id)
    else
      flash.now[:alert] = "投稿に失敗しました。" #キーをalaertに変更
      render :new
    end
  end



  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)  
  end

  def destroy
    list = List.find(params[:id]) # データ（レコード）を1件取得
    list.destroy # データ（レコード）を削除
    redirect_to 'lists' # 投稿一覧画面へリダイレクト
  end

  private
  # ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
