from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes
import os

TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")

async def ping(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("Pong desde bot 2!")

app = ApplicationBuilder().token(TOKEN).build()
app.add_handler(CommandHandler("ping", ping))

app.run_polling()
