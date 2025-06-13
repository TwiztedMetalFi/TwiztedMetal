use anchor_lang::prelude::*;

declare_id!("SUPERtok3n1111111111111111111111111111111");

#[program]
pub mod super_token {
    use super::*;

    pub fn mint(ctx: Context<MintToken>, amount: u64) -> Result<()> {
        let token = &mut ctx.accounts.token_account;
        token.amount += amount;
        Ok(())
    }

    pub fn burn(ctx: Context<BurnToken>, amount: u64) -> Result<()> {
        let token = &mut ctx.accounts.token_account;
        require!(token.amount >= amount, CustomError::InsufficientFunds);
        token.amount -= amount;
        Ok(())
    }
}

#[derive(Accounts)]
pub struct MintToken<'info> {
    #[account(mut)]
    pub token_account: Account<'info, TokenAccount>
}

#[derive(Accounts)]
pub struct BurnToken<'info> {
    #[account(mut)]
    pub token_account: Account<'info, TokenAccount>
}

#[account]
pub struct TokenAccount {
    pub owner: Pubkey,
    pub amount: u64,
}

#[error_code]
pub enum CustomError {
    #[msg("Insufficient funds")]
    InsufficientFunds,
}