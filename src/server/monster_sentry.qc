/*
 * Copyright (c) 2016-2020 Marco Cawthorne <marco@icculus.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF MIND, USE, DATA OR PROFITS, WHETHER
 * IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING
 * OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

/*QUAKED monster_sentry (0 0.8 0.8) (-16 -16 0) (16 16 72)

HALF-LIFE (1998) ENTITY

Sentry Gun

*/

enum
{
	SENT_IDLE,
	SENT_FIRE,
	SENT_SPIN,
	SENT_DEPLOY,
	SENT_RETIRE,
	SENT_DIE
};


class monster_sentry:NSMonster
{
	void(void) monster_sentry;

	virtual void(void) Spawned;
	virtual void(void) Death;
	virtual void(void) Respawn;

};

void
monster_sentry::Death(void)
{
	/* if we're already dead (corpse) don't change animations */
	if (IsAlive() == true) {
		SetFrame(SENT_DIE);
		Sound_Play(this, CHAN_VOICE, "monster_sentry.die");
	}

	/* set the functional differences */
	super::Death();
}

void
monster_sentry::Respawn(void)
{
	super::Respawn();

	SetFrame(SENT_IDLE);
	iBleeds = FALSE;
}

void
monster_sentry::Spawned(void)
{
	super::Spawned();

	Sound_Precache("monster_sentry.alert");
	Sound_Precache("monster_sentry.die");
	Sound_Precache("monster_sentry.idle");
	Sound_Precache("monster_sentry.retract");
}

void monster_sentry::monster_sentry(void)
{
	netname = "Sentry";
	model = "models/sentry.mdl";
	base_health = Skill_GetValue("sentry_health", 40);
	base_mins = [-16,-16,0];
	base_maxs = [16,16,72];
}
